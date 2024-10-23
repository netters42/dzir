defmodule Dzir.Webring do

  import Ecto.Query
  alias Dzir.Repo

  def random() do
    count = Repo.aggregate(from(website in Dzir.Webring.Website), :count, :id)
    random_offset = :rand.uniform(count) - 1
    Repo.one(from website in Dzir.Webring.Website, limit: 1, offset: ^random_offset).url
  end


  def next(nil) do
    random()
  end

  def next(referer) do
    referer_uri = URI.parse(referer).host |> :idna.to_unicode |> to_string
    case Dzir.Repo.one(from website in Dzir.Webring.Website, where: website.domain == ^referer_uri) do
      nil ->
        random()
      current ->
        next_site =
          (
            Repo.one(
              from website in Dzir.Webring.Website,
              where: website.id > ^current.id,
              order_by: [asc: website.id], limit: 1
            ) ||
            Repo.one(
              from website in Dzir.Webring.Website,
              order_by: [asc: website.id],
              limit: 1
            )
          )
        next_site.url
    end
  end


  def prev(nil) do
    random()
  end

  def prev(referer) do
    referer_uri = URI.parse(referer).host |> :idna.to_unicode |> to_string
    current = Dzir.Repo.one(from website in Dzir.Webring.Website, where: website.domain == ^referer_uri)
    prev_site =
      (
        Repo.one(
          from website in Dzir.Webring.Website,
          where: website.id < ^current.id,
          order_by: [desc: website.id], limit: 1
        ) ||
        Repo.one(
          from website in Dzir.Webring.Website,
          order_by: [desc: website.id],
          limit: 1
        )
      )
    prev_site.url
  end

  def list_websites(page) when is_bitstring(page) do
    page
    |> String.to_integer()
    |> list_websites()
  end

  def list_websites(page) do
    offset = (page - 1) * 10
    Dzir.Webring.Website
    |> order_by([w], asc: w.id)
    |> limit(10)
    |> offset(^offset)
    |> Repo.all()
  end
end

defmodule Dzir.Webring.Website do
  use Ecto.Schema
  import Ecto.Changeset

  schema "websites" do
    field :domain, :string
    field :url, :string
    field :title, :string
    field :description, :string
    field :owner_email, :string
    field :status, :boolean, default: true
    field :verified, :boolean, default: false
    field :tags, {:array, :string}, default: []

    timestamps()
  end

  def changeset(website, attrs) do
    website
    |> cast(attrs, [:domain, :url, :title, :description, :owner_email, :status, :verified, :tags])
    |> validate_required([:domain, :url])
  end
end

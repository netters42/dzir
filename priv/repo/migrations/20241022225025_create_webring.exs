defmodule Dzir.Repo.Migrations.CreateWebring do
  use Ecto.Migration

  def change do
    create table(:websites) do
      add :domain, :string, null: false
      add :url,    :string, null: false
      add :title,  :string
      add :description, :text
      add :owner_email, :string
      add :status,      :boolean, default: true
      add :verified,    :boolean, default: false
      add :tags,        {:array, :string}, default: []

      timestamps()
    end
  end
end

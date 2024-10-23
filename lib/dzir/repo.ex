defmodule Dzir.Repo do
  use Ecto.Repo,
    otp_app: :dzir,
    adapter: Ecto.Adapters.SQLite3
end

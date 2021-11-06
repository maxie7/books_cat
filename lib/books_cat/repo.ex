defmodule BooksCat.Repo do
  use Ecto.Repo,
    otp_app: :books_cat,
    adapter: Ecto.Adapters.Postgres
end

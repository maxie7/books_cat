defmodule BooksCatWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use BooksCatWeb, :controller

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(BooksCatWeb.ChangesetView)
    |> render(:"404")
  end

  # This clause will handle invalidated json data
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    IO.inspect(changeset.errors)
    conn
    |> put_status(:bad_request)
    |> put_view(BooksCatWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end
end

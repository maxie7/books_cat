defmodule BooksCatWeb.AuthorController do
  use BooksCatWeb, :controller

  alias BooksCat.Storage
  alias BooksCat.Storage.Author

  action_fallback BooksCatWeb.FallbackController

  def index(conn, _params) do
    authors = Storage.list_authors()
    render(conn, "index.json", authors: authors)
  end

  def create(conn, %{"author" => author_params}) do
    with {:ok, %Author{} = author} <- Storage.create_author(author_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.author_path(conn, :show, author))
      |> render("show.json", author: author)
    end
  end

  def show(conn, %{"id" => id}) do
    author = Storage.get_author!(id)
    render(conn, "show.json", author: author)
  end

  def update(conn, %{"id" => id, "author" => author_params}) do
    author = Storage.get_author!(id)

    with {:ok, %Author{} = author} <- Storage.update_author(author, author_params) do
      render(conn, "show.json", author: author)
    end
  end

  def delete(conn, %{"id" => id}) do
    author = Storage.get_author!(id)

    with {:ok, %Author{}} <- Storage.delete_author(author) do
      send_resp(conn, :no_content, "")
    end
  end
end

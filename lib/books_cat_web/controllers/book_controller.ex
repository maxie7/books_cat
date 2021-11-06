defmodule BooksCatWeb.BookController do
  use BooksCatWeb, :controller

  alias BooksCat.Storage
  alias BooksCat.Storage.Book

  action_fallback BooksCatWeb.FallbackController

  def index(conn, _params) do
    books = Storage.list_books()
    render(conn, "index.json", books: books)
  end

  def create(conn, %{"book" => book_params}) do
    with {:ok, %Book{} = book} <- Storage.create_book(book_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.book_path(conn, :show, book))
      |> render("show.json", book: book)
    end
  end

  def show(conn, %{"id" => id}) do
    book = Storage.get_book!(id)
    render(conn, "show.json", book: book)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = Storage.get_book!(id)

    with {:ok, %Book{} = book} <- Storage.update_book(book, book_params) do
      render(conn, "show.json", book: book)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Storage.get_book!(id)

    with {:ok, %Book{}} <- Storage.delete_book(book) do
      send_resp(conn, :no_content, "")
    end
  end
end

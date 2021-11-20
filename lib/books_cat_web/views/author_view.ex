defmodule BooksCatWeb.AuthorView do
  use BooksCatWeb, :view
  alias BooksCatWeb.AuthorView

  def render("index.json", %{authors: authors}) do
    %{data: render_many(authors, AuthorView, "author.json")}
  end

  def render("show.json", %{author: author}) do
    %{data: render_one(author, AuthorView, "author.json")}
  end

  def render("author.json", %{author: author}) do
    %{
      id: author.id,
      full_name: author.full_name
    }
  end
end

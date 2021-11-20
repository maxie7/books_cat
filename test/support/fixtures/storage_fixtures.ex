defmodule BooksCat.StorageFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BooksCat.Storage` context.
  """

  @doc """
  Generate a unique book isbn.
  """
  def unique_book_isbn, do: "some isbn#{System.unique_integer([:positive])}"

  @doc """
  Generate a book.
  """
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(%{
        authors: [],
        category: [],
        cover: "some cover",
        description: "some description",
        isbn: unique_book_isbn(),
        title: "some title"
      })
      |> BooksCat.Storage.create_book()

    book
  end

  @doc """
  Generate a unique author full_name.
  """
  def unique_author_full_name, do: "some full_name#{System.unique_integer([:positive])}"

  @doc """
  Generate a author.
  """
  def author_fixture(attrs \\ %{}) do
    {:ok, author} =
      attrs
      |> Enum.into(%{
        full_name: unique_author_full_name()
      })
      |> BooksCat.Storage.create_author()

    author
  end
end

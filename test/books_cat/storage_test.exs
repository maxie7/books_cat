defmodule BooksCat.StorageTest do
  use BooksCat.DataCase

  alias BooksCat.Storage

  describe "books" do
    alias BooksCat.Storage.Book

    import BooksCat.StorageFixtures

    @invalid_attrs %{authors: nil, category: nil, cover: nil, description: nil, isbn: nil, title: nil}

    test "list_books/0 returns all books" do
      book = book_fixture()
      assert Storage.list_books() == [book]
    end

    test "get_book!/1 returns the book with given id" do
      book = book_fixture()
      assert Storage.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      valid_attrs = %{authors: [], category: [], cover: "some cover", description: "some description", isbn: "some isbn", title: "some title"}

      assert {:ok, %Book{} = book} = Storage.create_book(valid_attrs)
      assert book.authors == []
      assert book.category == []
      assert book.cover == "some cover"
      assert book.description == "some description"
      assert book.isbn == "some isbn"
      assert book.title == "some title"
    end

    test "create_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Storage.create_book(@invalid_attrs)
    end

    test "update_book/2 with valid data updates the book" do
      book = book_fixture()
      update_attrs = %{authors: [], category: [], cover: "some updated cover", description: "some updated description", isbn: "some updated isbn", title: "some updated title"}

      assert {:ok, %Book{} = book} = Storage.update_book(book, update_attrs)
      assert book.authors == []
      assert book.category == []
      assert book.cover == "some updated cover"
      assert book.description == "some updated description"
      assert book.isbn == "some updated isbn"
      assert book.title == "some updated title"
    end

    test "update_book/2 with invalid data returns error changeset" do
      book = book_fixture()
      assert {:error, %Ecto.Changeset{}} = Storage.update_book(book, @invalid_attrs)
      assert book == Storage.get_book!(book.id)
    end

    test "delete_book/1 deletes the book" do
      book = book_fixture()
      assert {:ok, %Book{}} = Storage.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> Storage.get_book!(book.id) end
    end

    test "change_book/1 returns a book changeset" do
      book = book_fixture()
      assert %Ecto.Changeset{} = Storage.change_book(book)
    end
  end
end

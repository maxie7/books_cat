defmodule BooksCatWeb.AuthorControllerTest do
  use BooksCatWeb.ConnCase

  import BooksCat.StorageFixtures

  alias BooksCat.Storage.Author

  @create_attrs %{
    full_name: "some full_name"
  }
  @update_attrs %{
    full_name: "some updated full_name"
  }
  @invalid_attrs %{full_name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all authors", %{conn: conn} do
      conn = get(conn, Routes.author_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create author" do
    test "renders author when data is valid", %{conn: conn} do
      conn = post(conn, Routes.author_path(conn, :create), author: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.author_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "full_name" => "some full_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.author_path(conn, :create), author: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update author" do
    setup [:create_author]

    test "renders author when data is valid", %{conn: conn, author: %Author{id: id} = author} do
      conn = put(conn, Routes.author_path(conn, :update, author), author: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.author_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "full_name" => "some updated full_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, author: author} do
      conn = put(conn, Routes.author_path(conn, :update, author), author: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete author" do
    setup [:create_author]

    test "deletes chosen author", %{conn: conn, author: author} do
      conn = delete(conn, Routes.author_path(conn, :delete, author))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.author_path(conn, :show, author))
      end
    end
  end

  defp create_author(_) do
    author = author_fixture()
    %{author: author}
  end
end

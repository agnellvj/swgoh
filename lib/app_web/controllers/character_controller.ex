defmodule AppWeb.CharacterController do
  use AppWeb, :controller

  alias App.Swgoh
  alias App.Swgoh.Character

  def index(conn, _params) do
    characters = Swgoh.list_characters()
    render(conn, "index.html", characters: characters)
  end

  def new(conn, _params) do
    changeset = Swgoh.change_character(%Character{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"character" => character_params}) do
    case Swgoh.create_character(character_params) do
      {:ok, character} ->
        conn
        |> put_flash(:info, "Character created successfully.")
        |> redirect(to: character_path(conn, :show, character))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    character = Swgoh.get_character!(id)
    render(conn, "show.html", character: character)
  end

  def edit(conn, %{"id" => id}) do
    character = Swgoh.get_character!(id)
    changeset = Swgoh.change_character(character)
    render(conn, "edit.html", character: character, changeset: changeset)
  end

  def update(conn, %{"id" => id, "character" => character_params}) do
    character = Swgoh.get_character!(id)

    case Swgoh.update_character(character, character_params) do
      {:ok, character} ->
        conn
        |> put_flash(:info, "Character updated successfully.")
        |> redirect(to: character_path(conn, :show, character))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", character: character, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    character = Swgoh.get_character!(id)
    {:ok, _character} = Swgoh.delete_character(character)

    conn
    |> put_flash(:info, "Character deleted successfully.")
    |> redirect(to: character_path(conn, :index))
  end
end

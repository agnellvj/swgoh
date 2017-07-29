defmodule App.SwgohTest do
  use App.DataCase

  alias App.Swgoh

  describe "characters" do
    alias App.Swgoh.Character

    @valid_attrs %{data: %{}, name: "some name"}
    @update_attrs %{data: %{}, name: "some updated name"}
    @invalid_attrs %{data: nil, name: nil}

    def character_fixture(attrs \\ %{}) do
      {:ok, character} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Swgoh.create_character()

      character
    end

    test "list_characters/0 returns all characters" do
      character = character_fixture()
      assert Swgoh.list_characters() == [character]
    end

    test "get_character!/1 returns the character with given id" do
      character = character_fixture()
      assert Swgoh.get_character!(character.id) == character
    end

    test "create_character/1 with valid data creates a character" do
      assert {:ok, %Character{} = character} = Swgoh.create_character(@valid_attrs)
      assert character.data == %{}
      assert character.name == "some name"
    end

    test "create_character/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Swgoh.create_character(@invalid_attrs)
    end

    test "update_character/2 with valid data updates the character" do
      character = character_fixture()
      assert {:ok, character} = Swgoh.update_character(character, @update_attrs)
      assert %Character{} = character
      assert character.data == %{}
      assert character.name == "some updated name"
    end

    test "update_character/2 with invalid data returns error changeset" do
      character = character_fixture()
      assert {:error, %Ecto.Changeset{}} = Swgoh.update_character(character, @invalid_attrs)
      assert character == Swgoh.get_character!(character.id)
    end

    test "delete_character/1 deletes the character" do
      character = character_fixture()
      assert {:ok, %Character{}} = Swgoh.delete_character(character)
      assert_raise Ecto.NoResultsError, fn -> Swgoh.get_character!(character.id) end
    end

    test "change_character/1 returns a character changeset" do
      character = character_fixture()
      assert %Ecto.Changeset{} = Swgoh.change_character(character)
    end
  end
end

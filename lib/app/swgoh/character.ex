defmodule App.Swgoh.Character do
  use Ecto.Schema
  import Ecto.Changeset
  alias App.Swgoh.Character


  schema "characters" do
    field :data, :map
    field :name, :string
  end

  @doc false
  def changeset(%Character{} = character, attrs) do
    character
    |> cast(attrs, [:name, :data])
    |> validate_required([:name, :data])
  end
end

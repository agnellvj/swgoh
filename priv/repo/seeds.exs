# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     App.Repo.insert!(%App.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias App.Swgoh.Character
alias App.Repo

defmodule App.Seeds do
  def store_it(row) do
    changeset = Character.changeset(%Character{}, row)
    Repo.insert!(changeset)
  end

  def read_json(filename) do
    with {:ok, body} <- File.read(filename),
         {:ok, json} <- Poison.decode(body), do: {:ok, json}
    do
      Enum.each(json, fn(x) -> Repo.insert! %Character{ name: Map.get(x, "name") } end)
    else
      err -> IO.inspect(err)
    end
  end
end

App.Seeds.read_json("/Users/vinny/work/swgoh/priv/repo/characters.json")

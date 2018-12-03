defmodule Mix.Tasks.Fabarea2 do
  @moduledoc false

  use Mix.Task

  @shortdoc "fabarea, adventofcode2018, distinct whole claims in fabric"
  def run(argv \\ ["./input.txt"]) do
    stream = argv |> List.first() |> File.stream!()
    # just get all the claims
    claims = stream |> Enum.map(&Fabarea.parse_claim/1)
    # now apply all the claims to the fabric
    fabric = claims |> Enum.reduce(%{}, &Fabarea.apply_claim/2)
    # now walk all claims (again), to filer for only those which have 100% 1's
    claims
    |> Enum.filter(fn(claim) -> unique_claim(fabric, claim) end)
    |> IO.inspect()
  end

  # if all of the values in the fabric are 1, it's a whole, unique_claim
  def unique_claim(%{} = fabric, %Fabarea.Claim{} = claim) do
    claim
    |> Fabarea.claim_coords()
    |> Enum.all?(fn(coord) -> Map.get(fabric, coord) == 1 end)
  end
end

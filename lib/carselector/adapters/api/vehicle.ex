defmodule CarSelector.Adapters.API.Vehicle do
  import CarSelector.Adapters.API.Utils

  def fetch(id) do
    case get_json(url("/vehicles/" <> id)) do
      {:ok, raw_data} ->
        {:ok, CarSelector.Vehicle.build(raw_data)}
      result ->
        result
    end
  end
end

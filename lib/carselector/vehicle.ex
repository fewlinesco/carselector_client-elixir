defmodule CarSelector.Vehicle do
  defstruct [:id, :brand, :brand_id, :engine, :engine_id, :model, :model_id]

  @type t :: %__MODULE__{
    id: uuid,
    brand: CarSelector.Brand.t,
    brand_id: uuid,
    engine: CarSelector.Engine.t,
    engine_id: uuid,
    model: CarSelector.Mode.t,
    model_id: uuid
  }
  @type uuid :: String.t

  @callback fetch(uuid) :: t

  def build(raw_data), do: build(raw_data, %__MODULE__{})
  def build(raw_data, vehicle) when is_map(raw_data) do
    build(Enum.into(raw_data, []), vehicle)
  end
  def build([], vehicle) do
    vehicle
  end
  def build([{"id", id} | raw_data], vehicle) do
    build(raw_data, Map.put(vehicle, :id, id))
  end
  def build([{"brand", raw_brand} | raw_data], vehicle) do
    build(raw_data, Map.put(vehicle, :brand, CarSelector.Brand.build(raw_brand)))
  end
  def build([{"brand_id", brand_id} | raw_data], vehicle) do
    build(raw_data, Map.put(vehicle, :brand_id, brand_id))
  end
  def build([{"engine", raw_engine} | raw_data], vehicle) do
    build(raw_data, Map.put(vehicle, :engine, CarSelector.Engine.build(raw_engine)))
  end
  def build([{"engine_id", engine_id} | raw_data], vehicle) do
    build(raw_data, Map.put(vehicle, :engine_id, engine_id))
  end
  def build([{"model", raw_model} | raw_data], vehicle) do
    build(raw_data, Map.put(vehicle, :model, CarSelector.Model.build(raw_model)))
  end
  def build([{"model_id", model_id} | raw_data], vehicle) do
    build(raw_data, Map.put(vehicle, :model_id, model_id))
  end
  def build([_skipped_data | raw_data], vehicle) do
    build(raw_data, vehicle)
  end

  @doc """
  Fetch a specific vehicle based on its CarSelector ID.

  Returns either `{:ok, vehicle}` or `{:error, reason}`.

  ## Examples

      iex> CarSelector.Vehicle.fetch("d2dec69f-327d-45e6-b460-332370da9237")
      {:ok,
       %CarSelector.Vehicle{brand: %CarSelector.Brand{id: "aa82f8ea-0362-441d-941f-e73081776a6f",
                                                      name: "BMW",
                                                      tecdoc_id: "1296"},
                            brand_id: "aa82f8ea-0362-441d-941f-e73081776a6f",
                            engine: %CarSelector.Engine{id: "c97e1efc-7350-4056-bcc4-9c0fb43d3b2c",
                                                        name: "725 tds",
                                                        tecdoc_id: "4183"},
                            engine_id: "c97e1efc-7350-4056-bcc4-9c0fb43d3b2c",
                            id: "d2dec69f-327d-45e6-b460-332370da9237",
                            model: %CarSelector.Model{id: "9ccf141f-7a14-4a7b-bc04-7b37039bd7dd",
                                                      name: "7",
                                                      tecdoc_id: "4928"},
                            model_id: "9ccf141f-7a14-4a7b-bc04-7b37039bd7dd"}}
  """
  def fetch(id) do
    CarSelector.Adapters.API.Vehicle.fetch(id)
  end
end

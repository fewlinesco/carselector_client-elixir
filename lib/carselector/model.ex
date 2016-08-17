defmodule CarSelector.Model do
  defstruct [:id, :name, :tecdoc_id]

  @type t :: %__MODULE__{
    id: uuid,
    name: String.t,
    tecdoc_id: String.t
  }
  @type uuid :: String.t

  def build(raw_data), do: build(raw_data, %__MODULE__{})
  def build(raw_data, model) when is_map(raw_data) do
    build(Enum.into(raw_data, []), model)
  end
  def build([], model) do
    model
  end
  def build([{"id", id} | raw_data], model) do
    build(raw_data, Map.put(model, :id, id))
  end
  def build([{"name", name} | raw_data], model) do
    build(raw_data, Map.put(model, :name, name))
  end
  def build([{"tecdoc-id", tecdoc_id} | raw_data], model) do
    build(raw_data, Map.put(model, :tecdoc_id, tecdoc_id))
  end
  def build([_skipped_data | raw_data], model) do
    build(raw_data, model)
  end
end

defmodule CarSelector do
  def private_api_key, do: get_env(:private_api_key)

  def url, do: get_env(:url, "https://carselector.groomgroom.co/api")

  def version, do: get_env(:version, 20160719)

  defp get_env(key, default_value \\ nil) do
    case Application.get_env(:carselector, key, default_value) do
      {:system, value} ->
        System.get_env(value)
      value ->
        value
    end
  end
end

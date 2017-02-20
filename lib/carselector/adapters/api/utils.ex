defmodule CarSelector.Adapters.API.Utils do
  def get_json(url) do
    with {:ok, %HTTPoison.Response{body: body}} <- HTTPoison.get(url, headers()),
         {:ok, json} <- Poison.decode(body),
         {:ok, data} <- handle_data(json),
    do: {:ok, data}
  end

  def url(path) do
    base_url() <> path
  end

  defp api_version do
    CarSelector.version
  end

  defp base_url do
    CarSelector.url
  end

  defp handle_data(errors = %{"errors" => _errors}) do
    {:error, errors}
  end
  defp handle_data(json) when is_map(json) do
    {:ok, parse_result(json)}
  end
  defp handle_data(error) when is_binary(error) do
    {:error, %{"errors" => error}}
  end

  defp headers do
    %{"Authorization" => "Token=#{private_api_key()}",
      "Content-Type" => "application/vnd.api+json",
      "CarSelector-Version" => api_version()}
  end

  defp private_api_key do
    CarSelector.private_api_key
  end

  defp parse_result(data) when is_map(data) do
    data
    |> parse_relationships
    |> Map.merge(data["attributes"] || %{})
    |> Map.put_new("id", fetch_id(data))
    |> Map.put_new("type", fetch_type(data))
  end

  defp fetch_id(%{"data" => %{"id" => id}}), do: id
  defp fetch_id(%{"id" => id}), do: id
  defp fetch_id(_), do: nil

  defp fetch_type(%{"data" => %{"type" => type}}), do: type
  defp fetch_type(%{"type" => type}), do: type
  defp fetch_type(_), do: nil

  defp parse_relationships(%{"data" => %{"relationships" => nil}}), do: %{}
  defp parse_relationships(data = %{"data" => %{"relationships" => relations}}) do
    Enum.reduce relations, %{}, fn
      ({_name, %{"data" => nil}}, old_relations) -> old_relations
      ({name, %{"data" => %{"id" => id}}}, old_relations) ->
        old_relations
        |> Map.put("#{name}_id", id)
        |> Map.put(name, parse_result(find_relationship_from_id_and_type(data, id, name)))
      ({name, %{"data" => ids}}, rel) when is_list(ids) ->
        rel
        |> Map.put("#{name}_ids", Enum.map(ids, &(&1["id"])))
        |> Map.put("#{name}_ids", Enum.map(ids, &find_relationship_from_id_and_type(data, &1["id"], &1["type"])))
    end
  end
  defp parse_relationships(_), do: %{}

  defp find_relationship_from_id_and_type(data, id, type) do
    data["included"]
    |> Enum.filter(&(&1["type"] == type && &1["id"] == id))
    |> Enum.at(0)
  end
end

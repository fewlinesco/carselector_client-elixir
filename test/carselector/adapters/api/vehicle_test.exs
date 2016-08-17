defmodule CarSelector.Adapters.API.VehicleTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "fetch: when vehicle ID exists" do
    use_cassette "vehicle-fetch--when_vehicle_id_exists" do
      {:ok, vehicle} = CarSelector.Adapters.API.Vehicle.fetch("d2dec69f-327d-45e6-b460-332370da9237")

      assert "BMW" == vehicle.brand.name
      assert "725 tds" == vehicle.engine.name
      assert "7" == vehicle.model.name
    end
  end
end

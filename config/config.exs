use Mix.Config

config :carselector, namespace: CarSelector

config :carselector,
  adapter: API,
  private_api_key: {:system, "CARSELECTOR_API_KEY"},
  url: "https://carselector.groomgroom.co/api",
  version: 20160719

import_config "#{Mix.env}.exs"

defmodule CarSelector.Mixfile do
  use Mix.Project

  @project_url "https://github.com/fewlinesco/carselector_client-elixir"

  def project do
    [app: :carselector,
     version: "0.1.0",
     elixir: "~> 1.3",
     source_url: @project_url,
     homepage_url: @project_url,
     name: "CarSelector client",
     description: "A client for the CarSelector API",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     docs: [main: "README", extras: ["README.md"]],
     package: package,
     deps: deps()]
  end

  def application do
    [applications: [:logger, :httpoison, :poison]]
  end

  defp deps do
    [
      {:dogma, "~> 0.1.7", only: [:dev, :test]},
      {:httpoison, "~> 0.9.0"},
      {:poison, "~> 2.2.0"},
      {:exvcr, "~> 0.7", only: :test}
    ]
  end

  defp package do
    [
      maintainers: ["Kevin Disneur", "Thomas Gautier"],
      licenses: ["MIT"],
      links: %{"GitHub" => @project_url}
    ]
  end
end

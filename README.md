# CarSelector

An Elixir wrapper around the [CarSelector API](http://carselector.groomgroom.co).

## Installation

The package can be installed as:

1. Add `carselector` to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [{:carselector, "~> 0.1.0"}]
  end
  ```
2. Setup your configuration:

  ```elixir
  # In your config/config.exs file
  config :carselector,
    private_api_key: "xxxx-xxxx-xxxx-xxxx" # OR `{:system, "CARSELECTOR_API_KEY"}`
  ```

## Contributing

Before opening a pull request you can open an issue if you have any question or need some guidance.

Here's how to setup the project:

```
$ git clone https://github.com/fewlinesco/carselector_client-elixir.git
$ cd carselector_client-elixir
$ mix deps.get
$ mix test
```

Once you've made your additions and `mix test` passes, go ahead and open a Pull Request.

## License

The CarSelector Elixir client is released under [The MIT License (MIT)](https://opensource.org/licenses/MIT).

# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :phx_shadcn_dev,
  generators: [timestamp_type: :utc_datetime]

# Configure the endpoint
config :phx_shadcn_dev, PhxShadcnDevWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: PhxShadcnDevWeb.ErrorHTML, json: PhxShadcnDevWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: PhxShadcnDev.PubSub,
  live_view: [signing_salt: "bHDLQJpW"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.25.4",
  phx_shadcn_dev: [
    args:
      ~w(js/app.js --bundle --target=es2022 --outdir=../priv/static/assets/js --external:/fonts/* --external:/images/* --alias:@=.),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => [Path.expand("../deps", __DIR__), Path.expand("../..", __DIR__), Mix.Project.build_path()]}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "4.1.12",
  phx_shadcn_dev: [
    args: ~w(
      --input=assets/css/app.css
      --output=priv/static/assets/css/app.css
    ),
    cd: Path.expand("..", __DIR__)
  ]

# Configure Elixir's Logger
config :logger, :default_formatter,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configure phx_shadcn error translator
config :phx_shadcn,
  error_translator_function: {PhxShadcnDevWeb.CoreComponents, :translate_error}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

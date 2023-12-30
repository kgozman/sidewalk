# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

# Configure Sidewalk database
config :sidewalk, Sidewalk.Repo,
 username: "username",
 password: "password",
 database: "sidewalk_dev",
 hostname: "localhost",
 show_sensitive_data_on_connection_error: true,
 pool_size: 10

config :sidewalk, :pow,
  user: Sidewalk.Users.Users,
  repo: Sidewalk.Repo,
  ecto_repos: [Sidewalk.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :sidewalk, SidewalkWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [html: SidewalkWeb.ErrorHTML, json: SidewalkWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Sidewalk.PubSub,
  # live_view: [signing_salt: "sR51TAX7"],
  live_view: [signing_salt: "*S2e68g!Zg2I$RRYto7f1U5UY#BUNWF263vUdHfiju4zJ@6cZoort^eZIzQhK@e3"],
  session_options: [
      store: :cookie,
      key: "u7kR^AQ&Y6#o2!yLhUrLmcdFZNGEX9$NjfKQpLnFPxi@AitHXao@uFVx5C#ktUbu",
      signing_salt: "sR51TAX7"
    ]
# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :sidewalk, Sidewalk.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.3.2",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :sidewalk, :pow,
  user: Sidewalk.Users.User,
  repo: Sidewalk.Repo,
  web_module: SidewalkWeb


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

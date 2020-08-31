import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :qnotes, Qnotes.Repo,
  username: "postgres",
  password: "postgres",
  database: "qnotes_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :qnotes, QnotesWeb.Endpoint,
  http: [port: 4002],
  secret_key_base: "nQI6/GgVrRi0A9hDlZ/VhTbhL0IlToG4mjvtBX4oxq5Pg7XhU6Mgh9eLi5KY0pSE",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

import Config

config :qnotes, QnotesWeb.Endpoint,
  url: [host: System.get_env("HOST")],
  http: [:inet6, port: String.to_integer(System.get_env("PORT"))],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  live_view: [signing_salt: System.get_env("SECRET_KEY_BASE")]

config :qnotes, Qnotes.Repo,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("PG_POOL_SIZE", "20"))

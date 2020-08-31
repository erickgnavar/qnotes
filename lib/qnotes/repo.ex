defmodule Qnotes.Repo do
  use Ecto.Repo,
    otp_app: :qnotes,
    adapter: Ecto.Adapters.Postgres
end

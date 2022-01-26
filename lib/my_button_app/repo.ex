defmodule MyButtonApp.Repo do
  use Ecto.Repo,
    otp_app: :my_button_app,
    adapter: Ecto.Adapters.Postgres
end

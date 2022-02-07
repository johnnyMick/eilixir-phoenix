defmodule MyButtonAppWeb.PageController do
  use MyButtonAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def cursors(conn, _params) do
    render(conn, "cursors.html",
      user_token: Phoenix.Token.sign(MyButtonAppWeb.Endpoint, "user socket", MyButtonApp.Names.generate())
    )
  end
end

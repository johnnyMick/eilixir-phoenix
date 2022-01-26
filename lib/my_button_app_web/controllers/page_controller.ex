defmodule MyButtonAppWeb.PageController do
  use MyButtonAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

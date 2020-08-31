defmodule QnotesWeb.PageController do
  use QnotesWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

defmodule Banlist.PageController do
  use Banlist.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

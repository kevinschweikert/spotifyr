  defmodule SpotifyrWeb.OAuthController do
  use SpotifyrWeb, :controller

  def authorize(conn, _params) do
    redirect(conn, external: Spotify.Authorization.url())
  end

  def authenticate(conn, params) do
    case Spotify.Authentication.authenticate(conn, params) do
      {:ok, conn} ->
        redirect(conn, to: "/")

      {:error, reason, conn} ->
        Logger.error(reason)
    end
    end
end

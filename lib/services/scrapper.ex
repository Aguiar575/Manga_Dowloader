defmodule MangaCrawler.Scrapper do
  use HTTPoison.Base

  @spec request_url(binary) :: any
  def request_url(url) do
    case HTTPoison.get(url, [], timeout: 30000, recv_timeout: 30000) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:not_found, "404"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end

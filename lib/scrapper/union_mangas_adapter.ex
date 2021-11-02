defmodule MangaCrawler.UnionMangasAdapter do

  use HTTPoison.Base

  @spec get_manga_url(binary) :: any
  def get_manga_url(url) do
    IO.puts("Downloading manga from: "<>url)
    url
    |> request_site()
  end

  defp request_site(url) do
    case HTTPoison.get(url, [], [timeout: 30000, recv_timeout: 30000]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
        |> get_manga_list()
        |> get_manga_pages()
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

  defp get_manga_list(body) do
    body
    |> Floki.find("div.text-center img")
  end

  defp get_manga_pages(items) do
    items
    |> Floki.attribute("src")
  end

end

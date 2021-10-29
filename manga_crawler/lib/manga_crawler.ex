defmodule MangaCrawler do

  use HTTPoison.Base
  @moduledoc """
  Documentation for `MangaCrawler`.
  """

  @doc """
    Get manga from url.

    ## Examples

        iex> MangaCrawler.getMangaByUrl("http://www.mangareader.net/naruto/")
        :Naruto
    """
  def getMangaByUrl(url) do
    url
    |> requestSite()
    |> getMangaList()
    |> getMangaPagesFromList()
  end

  defp requestSite(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
         body
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

  defp getMangaList(body) do
    body
    |> Floki.find("div.container-chapter-reader img")
  end

  defp getMangaPagesFromList(items) do
    items
    |> Floki.attribute("src")
  end

end

#"https://readmanganato.com/manga-aa951409/chapter-1" |> MangaCrawler.requestSite

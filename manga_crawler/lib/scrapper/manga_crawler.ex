defmodule MangaCrawler do

  use HTTPoison.Base
  alias MangaCrawler.ImageDownloader
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
    |> ImageDownloader.downloadListOfImages()
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
    |> Floki.find("div.text-center img")
  end

  defp getMangaPagesFromList(items) do
    items
    |> Floki.attribute("src")
  end

end

#"https://unionmangas.top/leitor/Boku_no_Hero_Academia_(pt-br)/331" |> MangaCrawler.getMangaByUrl

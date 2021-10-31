defmodule MangaCrawler do

  use HTTPoison.Base

  def getMangaByUrl(url) do
    IO.puts("Downloading manga from: "<>url)
    url
    |> requestSite()
  end

  defp requestSite(url) do
    case HTTPoison.get(url, [], [timeout: 30000, recv_timeout: 30000]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
        |> getMangaList()
        |> getMangaPagesFromList()
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

#"http://unionleitor.top/leitor/Kimetsu_no_Yaiba/02" |> MangaCrawler.Interface.downlaodCapInPdf()

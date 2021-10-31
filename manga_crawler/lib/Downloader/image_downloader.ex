defmodule  MangaCrawler.ImageDownloader do
  use HTTPoison.Base

  def downloadDir(baseUrl, folderName, chapter) do
    baseUrl <> "/" <> folderName <> "/" <> chapter <> "/"
  end

  def downloadListOfImages(urls) do
    Enum.each(urls, fn x -> downloadImage(x) end)

    Enum.at(urls, trunc(length(urls) / 2))
    |> getLocalToWrite()
  end

  defp downloadImage(url) do
    localToWrite = getLocalToWrite(url)
    urlWithoutBLank = String.replace(url, " ", "%20")

    {:ok, resp} = :httpc.request(:get, {urlWithoutBLank, []}, [], [body_format: :binary])
    {{_, 200, 'OK'}, _headers, body} = resp

    writeFile(body, localToWrite <> getPageNumer(urlWithoutBLank) <> ".jpg")
    localToWrite
  end

  defp writeFile(bites, path) do
    with :ok <- File.mkdir_p(Path.dirname(path)) do
      File.write(path, bites)
    end
  end

  defp getPageNumer(page) do
    String.split(page, "/")
    |> List.last()
    |> String.split(".")
    |> List.first()
  end

  defp getLocalToWrite(url) do
    listOfContents = url |> String.replace(" ", "_") |>String.split("/")

    File.cwd! <> "/mangalib"
    |> downloadDir(Enum.at(listOfContents, -3), Enum.at(listOfContents, -2))
  end

end

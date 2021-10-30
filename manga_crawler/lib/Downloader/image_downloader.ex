defmodule  MangaCrawler.ImageDownloader do
  use HTTPoison.Base

  defp getPageNumer(page) do
    String.split(page, "/")
    |> List.last()
    |> String.split(".")
    |> List.first()
  end

  defp downloadDir, do: "/Users/arthuraguiar/Downloads/Chapter/"

  def downloadListOfImages(urls) do
    Enum.each(urls, fn x -> downloadImage(x) end)
  end

  def downloadImage(url) do
    urlWithoutBLank = String.replace(url, " ", "%20")
    {:ok, resp} = :httpc.request(:get, {urlWithoutBLank, []}, [], [body_format: :binary])
    {{_, 200, 'OK'}, _headers, body} = resp
    writeFile(body, downloadDir() <> getPageNumer(urlWithoutBLank) <> ".png")
  end

  def writeFile(bites, path) do
    with :ok <- File.mkdir_p(Path.dirname(path)) do
      File.write(path, bites)
    end
  end
end

#https://images-na.ssl-images-amazon.com/images/I/71+mDoHG4mL.png
#"https://images-na.ssl-images-amazon.com/images/I/71+mDoHG4mL.png" |> MangaCrawler.ImageDownloader.getPageNumer()

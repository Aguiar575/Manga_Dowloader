defmodule MangaCrawler.Interface do
  alias MangaCrawler.ImageDownloader


  def downlaodCapInFolder(url) do
    url
    |> client()
  end

  defp client(url) do
    url
    |> MangaCrawler.getMangaByUrl
    |> ImageDownloader.downloadListOfImages()
  end
end

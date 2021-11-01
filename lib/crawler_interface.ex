defmodule MangaCrawler.Interface do
  alias MangaCrawler.ImageDownloader
  alias MangaCrawler.PdfConversor


  def downlaodCapInFolder(url) do
    url
    |> client()
  end

  def downlaodCapInPdf(url) do
    url
    |> downlaodCapInFolder()
    |> PdfConversor.convertToPdf()
  end

  defp client(url) do
    url
    |> MangaCrawler.getMangaByUrl
    |> ImageDownloader.downloadListOfImages()
  end
end

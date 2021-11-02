defmodule MangaCrawler.Client do
  alias MangaCrawler.ImageDownloader
  alias MangaCrawler.PdfConversor
  alias MangaCrawler.UnionMangasAdapter


  def download_cap_only_images(url) do
    url
    |> client()
  end

  def download_cap_pdf(url) do
    url
    |> download_cap_only_images()
    |> PdfConversor.convert_to_pdf()
  end

  defp client(url) do
    url
    |> UnionMangasAdapter.get_manga_url()
    |> ImageDownloader.download_images()
  end

  def union_mangas_client() do
    url = IO.gets("cap url form unionmangas.top: ") |> to_string() |> String.trim()

    case String.trim(IO.gets("convert to PDF? (y/n): ")) do
      "y" ->
        IO.puts("downloading cap pdf...")
        download_cap_pdf(url)
      "n" ->
        IO.puts("downloading cap images...")
        download_cap_only_images(url)
      _ ->
        IO.puts("invalid option")
        union_mangas_client()
    end
  end
end

MangaCrawler.Client.union_mangas_client()

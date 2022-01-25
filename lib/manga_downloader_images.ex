defmodule MangaCrawler.Client.DownloadImages do
  @behaviour MangaCrawler.Behaviours.Client

  alias MangaCrawler.HandleWithImgList
  alias MangaCrawler.Scrapper
  alias MangaCrawler.ImgExtractor

  @spec get_manga(binary) :: {:error, any} | {:not_found, <<_::64, _::_*8>>}
  def get_manga(url) do
    response = Scrapper.request_url(url)

    case response do
      {:ok, body} ->
        ImgExtractor.extract_img_urls(body)
        |> HandleWithImgList.download_images()

      {:not_found, code} ->
        {:not_found, "Page not found #{code}"}

      {:error, msg} ->
        {:error, msg}
    end
  end
end

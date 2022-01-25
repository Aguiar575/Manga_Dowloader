defmodule MangaCrawler.HandleWithImgList do
  alias MangaCrawler.ImageDownloader

  @spec download_images(maybe_improper_list) :: :ok | {:error, binary}
  def download_images(url_list) do
    url_list |> get_images("none")
  end

  @spec get_images(maybe_improper_list, any) :: {:error, binary} | {:ok, any}
  defp get_images([h | t], _path) do
    case ImageDownloader.download_image(h) do
      {:ok, path} -> get_images(t, path)
      {:error, message} -> {:error, message}
    end
  end

  defp get_images([], path), do: {:ok, path}
end

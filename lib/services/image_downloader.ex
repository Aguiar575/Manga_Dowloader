defmodule MangaCrawler.ImageDownloader do
  use HTTPoison.Base

  @spec download_image(binary) :: {:error, binary} | {:ok, <<_::24, _::_*8>>}
  def download_image(url) do
    localToWrite = get_path_to_save(url)
    urlWithoutBLank = String.replace(url, " ", "%20")

    case :httpc.request(:get, {urlWithoutBLank, []}, [], body_format: :binary) do
      {:ok, resp} ->
        {{_, 200, 'OK'}, _headers, body} = resp
        save_file(body, localToWrite <> get_page_number(urlWithoutBLank) <> ".jpg")
        {:ok, localToWrite}

      _ ->
        {:error, urlWithoutBLank}
    end
  end

  defp get_path_to_save(url) do
    listOfContents = url |> String.replace(" ", "_") |> String.split("/")

    (File.cwd!() <> "/mangalib")
    |> download_dir(Enum.at(listOfContents, -3), Enum.at(listOfContents, -2))
  end

  defp save_file(bites, path) do
    with :ok <- File.mkdir_p(Path.dirname(path)) do
      File.write(path, bites)
    end
  end

  defp get_page_number(page) do
    String.split(page, "/")
    |> List.last()
    |> String.split(".")
    |> List.first()
  end

  @spec download_dir(binary, binary, binary) :: <<_::24, _::_*8>>
  def download_dir(baseUrl, folderName, chapter) do
    baseUrl <> "/" <> folderName <> "/" <> chapter <> "/"
  end
end

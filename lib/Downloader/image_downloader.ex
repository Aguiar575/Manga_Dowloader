defmodule  MangaCrawler.ImageDownloader do
  use HTTPoison.Base

  @spec download_dir(binary, binary, binary) :: <<_::24, _::_*8>>
  def download_dir(baseUrl, folderName, chapter) do
    baseUrl <> "/" <> folderName <> "/" <> chapter <> "/"
  end

  @spec download_images(list) :: <<_::24, _::_*8>>
  def download_images(urls) do
    Enum.each(urls, fn x -> download_image(x) end)

    Enum.at(urls, trunc(length(urls) / 2))
    |> get_path_to_save()
  end

  defp download_image(url) do
    localToWrite = get_path_to_save(url)
    urlWithoutBLank = String.replace(url, " ", "%20")

    case :httpc.request(:get, {urlWithoutBLank, []}, [], [body_format: :binary]) do
      {:ok, resp} ->
        {{_, 200, 'OK'}, _headers, body} = resp
        save_file(body, localToWrite <> get_page_number(urlWithoutBLank) <> ".jpg")
        localToWrite

      _ ->
        IO.puts("Error to Download image: " <> urlWithoutBLank)
    end
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

  defp get_path_to_save(url) do
    listOfContents = url |> String.replace(" ", "_") |>String.split("/")

    File.cwd! <> "/mangalib"
    |> download_dir(Enum.at(listOfContents, -3), Enum.at(listOfContents, -2))
  end

end

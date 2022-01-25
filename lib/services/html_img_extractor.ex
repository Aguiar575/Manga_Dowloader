defmodule MangaCrawler.ImgExtractor do
  @spec extract_img_urls(
          binary
          | [
              binary
              | {:comment, binary}
              | {:pi | binary, binary | [{any, any}], list}
              | {:doctype, binary, binary, binary}
            ]
        ) :: list
  def extract_img_urls(body) do
    body
    |> Floki.find("div.text-center img")
    |> Floki.attribute("src")
  end
end

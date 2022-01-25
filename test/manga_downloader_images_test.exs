defmodule MangaCrawler.Client.DownloadImagesTest do
  alias MangaCrawler.Client.DownloadImages
  use ExUnit.Case

  @manga_url 'http://unionleitor.top/leitor/One%20Piece/1037'
  @base_folder_structure File.cwd!() <> "/mangalib"
  test "Download images test" do
    assert DownloadImages.get_manga(@manga_url) == {:ok, "#{@base_folder_structure}/One_Piece/1037/"}
    File.rm_rf!(@base_folder_structure)
  end
end

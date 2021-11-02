defmodule MangaCrawler.PdfConversor do

  @spec convert_to_pdf(any) :: port
  def convert_to_pdf(chapter_path) do
    IO.puts("Converting #{chapter_path} to pdf")
    Port.open({:spawn, "python3.9 priv/pdf_conversor.py #{chapter_path}"}, [:binary])
  end
end

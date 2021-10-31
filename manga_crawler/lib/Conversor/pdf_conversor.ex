defmodule MangaCrawler.PdfConversor do
  def convertToPdf(chapter_path) do
    IO.puts("Converting #{chapter_path} to pdf")
    Port.open({:spawn, "python3.9 priv/pdf_conversor.py #{chapter_path}"}, [:binary])
  end
end

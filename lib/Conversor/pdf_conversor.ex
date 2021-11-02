defmodule MangaCrawler.PdfConversor do

  @python "python3.9"

  @spec convert_to_pdf(any) :: port
  def convert_to_pdf(chapter_path) do
    IO.puts("Converting #{chapter_path} to pdf")
    Port.open({:spawn, "#{@python} priv/pdf_conversor.py #{chapter_path}"}, [:binary])
  end
end

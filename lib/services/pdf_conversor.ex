defmodule MangaCrawler.PdfConversor do
  @python "python3.9"

  @spec to_pdf(any) :: {:ok, port}
  def to_pdf(chapter_path) do
    port = Port.open({:spawn, "#{@python} scripts/pdf_conversor.py #{chapter_path}"}, [:binary])
    {:ok, port}
  end
end

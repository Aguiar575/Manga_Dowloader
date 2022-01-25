defmodule MangaCrawler.PdfConversor do
  @python "python3.9"

  @spec to_pdf(any) :: {:ok, any}
  def to_pdf(chapter_path) do
    Port.open({:spawn, "#{@python} scripts/pdf_conversor.py #{chapter_path}"}, [:binary])
    {:ok, chapter_path}
  end
end

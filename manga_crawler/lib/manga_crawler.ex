defmodule MangaCrawler do

  use HTTPoison.Base

  @moduledoc """
  Documentation for `MangaCrawler`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> MangaCrawler.hello()
      :world

  """
  def requestSite(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
         getMangaList(body)
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

  def getMangaList(body) do
    IO.puts Floki.find(body, "div.container-chapter-reader")
  end
end

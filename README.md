# Manga_Downloader

Manga downloader client adapted to download chapters from the website [Union Mangás](https://unionmangas.top/home).

## Installation

to use the pdf generator you will need to have the `Pillow` library installed on your machine, the default version of the converter is python3.9, but you can change it by editing the Conversor/pdf_conversor.ex file.

```python
pip install Pillow
```

## Using the downloader 

Using the mix download all the necessary dependencies.

```elixir
mix deps.get 
```

Attention this client is only compatible with the site [Union Mangás](https://unionmangas.top/home), other sites may not return the desired result.

```elixir
mix run manga_downloader.exs 
```

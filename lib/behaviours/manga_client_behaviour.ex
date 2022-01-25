defmodule MangaCrawler.Behaviours.Client do
  @callback get_manga(binary) ::
              {:error, any} | {:not_found, <<_::64, _::_*8>>} | {:ok, <<_::24, _::_*8>>}
end

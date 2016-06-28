ExUnit.start()
Application.ensure_all_started(:bypass)
defmodule DollaTest.Fixtures do
  def receipt_with_iaps do
    {:ok, file} = File.read("test/fixtures/receipt_with_iaps.json")
    file
  end
end

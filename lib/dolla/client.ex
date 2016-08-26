defmodule Dolla.Client do
  alias Dolla.Response

  use HTTPoison.Base

  @prod_url "https://buy.itunes.apple.com/verifyReceipt"
  @sandbox_url "https://sandbox.itunes.apple.com/verifyReceipt"

  defmodule ServerError do
    defexception [:status_code, :message]

    def exception(status_code) do
      %ServerError{status_code: status_code}
    end
  end

  def verify(receipt_data, environment \\ :prod) do

    case post(url(environment), receipt_data) do
      {:ok, %HTTPoison.Response{status_code: 200, body: response}} ->
        case response do
          %{status: 0} -> {:ok, response}
          %{status: 21006} -> {:ok, response} # Subscription is expired. Carry on!
          %{status: 21007} -> verify(receipt_data, :sandbox)
          %{status: status} when status > 0 ->
            {:error, Response.handle_error(response)}
        end
      {:ok, %HTTPoison.Response{status_code: code, body: response}} when code > 299 ->
        {:error, %Response{error: ServerError.exception(code)}}
      {:error, error} -> {:error, %Response{error: error}}
    end
  end

  defp process_request_body(receipt_data) do
    %{"receipt-data" => receipt_data, "password" => password}
    |> Poison.encode!
  end

  defp password do
    Application.get_env(:dolla, :secret)
  end

  defp process_response_body(body) do
    case Poison.decode(body, as: Response.decode_template) do
      {:ok, response} -> response
      {:error, _} -> body
    end
  end

  defp url(:prod) do
    Application.get_env(:dolla, :endpoint, @prod_url)
  end

  defp url(:sandbox) do
    Application.get_env(:dolla, :sandbox, @sandbox_url)
  end
end

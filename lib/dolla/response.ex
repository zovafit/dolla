defmodule Dolla.Response do
  alias Dolla.Response
  alias Dolla.Receipt
  alias Dolla.InAppReceipt

  defstruct [:status, :environment, :receipt, :latest_receipt, :latest_receipt_info, :error]

  defmodule ValidationError do
    defexception [:status, :message]

    def exception(status) do
      %ValidationError{status: status, message: get_message(status)}
    end

    defp get_message(status) do
      case status do
        21002 -> "The data in the receipt-data property was malformed or missing."
        21003 -> "The receipt could not be authenticated."
        21004 -> "The shared secret you provided does not match the shared secret on file for your account."
        21005 -> "The receipt server is not currently available."
        21010 -> "The receipt could not be authorized."
        code -> "An unknown error code (#{code}) was returned."
      end
    end
  end

  defmodule ParseError do
    defexception [:body, :message]

    def exception(body) do
      %__MODULE__{message: "Could not parse response: #{String.slice(body, 0, 20)}...",
                  body: body
      }
    end
  end

  def handle_error(%{status: status} = response) do
    %Response{response | error: ValidationError.exception(status)}
  end

  def handle_error(response) do
    %Response{error: ParseError.exception(response)}
  end


  def decode_template do
    %Response{
      receipt: %Receipt{in_app: [%InAppReceipt{}]},
      latest_receipt_info: [%InAppReceipt{}]
    }
  end
end

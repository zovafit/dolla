defmodule Dolla.Response do
  alias Dolla.Response
  defstruct [:status, :receipt, :latest_receipt, :latest_receipt_info, :error]

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
        code -> "An unknown error code (#{code}) was returned."
      end
    end
  end

  def handle_error(response) do
    %Response{response | error: ValidationError.exception(response.status)}
  end
end

defmodule Dolla.InAppReceipt do
  alias Dolla.InAppReceipt
  use TimexPoison,
    keys: [:purchase_date, :original_purchase_date, :expires_date, :cancellation_date],
    format: "{ISOdate} {ISOtime} {Zname}"

  defstruct [:quantity, :transaction_id, :original_transaction_id, :purchase_date,
             :original_purchase_date, :expires_date, :cancellation_date, :app_item_id,
             :version_external_identifier, :web_order_line_item_id, :is_trial_period
            ]
  def decode_template do
    %InAppReceipt{}
  end
end

defmodule Dolla.InAppReceipt do
  defstruct [:quantity, :transaction_id, :original_transaction_id, :purchase_date,
             :original_purchase_date, :expires_date, :cancellation_date, :app_item_id,
             :version_external_identifier, :web_order_line_item_id, :is_trial_period
            ]
end

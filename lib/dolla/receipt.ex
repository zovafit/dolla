defmodule Dolla.Receipt do
  use TimexPoison,
    keys: [:creation_date, :expiration_date],
    format: "{ISOdate} {ISOtime} {Zname}"

  defstruct [:bundle_id, :application_version, :original_application_version,
             :creation_date, :expiration_date, :in_app]

end

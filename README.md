# Dolla
[![Build Status](https://travis-ci.org/zovafit/dolla.svg?branch=master)](https://travis-ci.org/zovafit/dolla)
## App Store Receipt IAP Verification in Elixir

Dolla provides a wrapper over Apple's app store receipt verification service in
Elixir.

![Illustrated sloth with caption: Dolla dolla bill, ya'll](sloth.jpg)

It aims to be relatively thin, giving you structs to play with instead of having
to deal withe logic and errors yourself.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add dolla to your list of dependencies in `mix.exs`:

        def deps do
          [{:dolla, "~> 0.2.1"}]
        end

  2. Ensure dolla is started before your application:

        def application do
          [applications: [:dolla]]
        end
        
  3. If you're verifying receipts with recurring subscriptions, configure the
     secret in your dev.exs and prod.exs respectively
     
        config :dolla, :secret, "YOUR_SECRET"

## Usage

Once you have your base64 encoded receipt data (see [Apple's docs](https://developer.apple.com/library/ios/releasenotes/General/ValidateAppStoreReceipt/Chapters/ValidateRemotely.html#//apple_ref/doc/uid/TP40010573-CH104-SW1) for more information), just pass them to `Dolla`.

```elixir
iex> Dolla.verify("A MASSIVE BUNCH OF BASE64")
{:ok, %Dolla.Response{status: 0, receipt: %Dolla.Receipt{...}}...}
```

Dolla returns a tuple, so you're probably going to want to match on that. If you
get `:ok` as the first element in the tuple, then your receipt has successfully
validated.

defmodule Dolla.Mixfile do
  use Mix.Project

  def project do
    [app: :dolla,
     version: "0.3.4",
     elixir: "~> 1.10",
     build_embedded: Mix.env() == :prod,
     start_permanent: Mix.env() == :prod,
     deps: deps(),
     package: package(),
     description: description()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [extra_applications: [:logger, :httpoison, :timex, :timex_poison],
     mod: {Dolla, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:httpoison, "~> 1.6"},
     {:bypass, "~> 1.0", only: [:test]},
     {:poison, "~> 3.0"},
     {:timex, "~> 3.6"},
     {:timex_poison, "~> 0.2.0"},
     {:ex_doc, ">= 0.0.0", only: :dev},
     {:plug_cowboy, "~> 2.3"}
    ]
  end

  defp description do
    """
    Dolla provides a wrapper over Apple's app store receipt verification service in Elixir.

   """
  end

  defp package do
    [
      name: :dolla,
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Andrew Harvey"],
      licenses: ["BSD"],
      links: %{
        "GitHub" => "https://github.com/zovafit/dolla"
      }
    ]
  end
end

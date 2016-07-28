defmodule Dolla.Mixfile do
  use Mix.Project

  def project do
    [app: :dolla,
     version: "0.0.2",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     package: package,
     description: description
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison, :timex],
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
    [{:httpoison, "~> 0.9.0"},
     {:bypass, "~> 0.5", only: [:test]},
     {:poison, "~> 1.5 or ~> 2.0"},
     {:timex, "~> 2.2"},
     {:timex_poison, "~> 0.1"}
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
      files: ["lib", "mix.exs", "README*", "LICENSE*", "config"],
      maintainers: ["Andrew Harvey"],
      licenses: ["BSD"],
      links: %{
        "GitHub" => "https://github.com/zovafit/dolla"
      }
    ]
  end
end

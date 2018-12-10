defmodule Marble.Mixfile do
  use Mix.Project

  @version "0.1.0"
  @deps    [
    {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
    {:mix_test_watch, "~> 0.9", only: :dev, runtime: false},
    {:libgraph, "~> 0.13"},
    # {:timex, "~> 3.1"},
  ]

  ############################################################

  def project do
    in_production = Mix.env == :prod
    [
      app:     :marble,
      version: @version,
      deps:    @deps,
      elixir:  "~> 1.7",
      build_embedded:  in_production,
      start_permanent: in_production,
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      # applications: [:timex]
    ]
  end

end

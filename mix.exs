defmodule Twituser.MixProject do
  use Mix.Project

  def project do
    [
      app: :twituser,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Twituser.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.0"},
      {:gen_stage, "~> 0.12"},
      {:postgrex, ">= 0.0.0"},
      {:twittex, "~> 0.3"},
      {:timex, "~> 3.1"}
    ]
  end
end

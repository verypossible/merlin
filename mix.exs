defmodule Merlin.MixProject do
  use Mix.Project

  def project do
    [
      app: :merlin,
      version: "0.1.1",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.0", only: :dev},
      {:clhi, "~> 0.0", only: :dev}
    ]
  end

  defp package do
    [
      description: "A wise alchemist to guide your project's setup.",
      maintainers: ["Very"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/verypossible/merlin"}
    ]
  end

  defp docs do
    [extras: ["README.md"]]
  end
end

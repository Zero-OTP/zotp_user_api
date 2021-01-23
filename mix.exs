defmodule ZotpUserApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :zotp_user_api,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ZotpUserApi.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
        {:zotp_user_lib, git: "https://github.com/Zero-OTP/zopt_user_lib.git"},
        {:poison, "~> 4.0.1"},
        {:plug_cowboy, "~> 2.4.1"}
    ]
  end
end

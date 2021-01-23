use Mix.Config

config :zotp_user_lib, postgrex_user: "postgres", postgrex_pass: "postgres"

config :logger,
  backends: [{LoggerFileBackend, :debug}]

config :logger, :debug,
  path: "logs/test.log",
  level: :debug,
  metadata: [:mfa, :file, :line, :pid],
  format: "[$date] [$time] $message [$metadata]\n"
  #metadata: [:application, :mfa , :error_code, :file, :line, :pid , :initial_call, :registered_name],

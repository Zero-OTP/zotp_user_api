use Mix.Config

config :zotp_user_lib, postgrex_user: "postgres", postgrex_pass: "postgres"

config :logger,
  backends: [{LoggerFileBackend, :info}]

config :logger, :info,
  path: "logs/prod.log",
  level: :info,
  metadata: [:mfa, :file, :line, :pid],
  format: "[$date] [$time] $message [$metadata]\n"
  #metadata: [:application, :mfa , :error_code, :file, :line, :pid , :initial_call, :registered_name],

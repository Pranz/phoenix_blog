use Mix.Config

config :personal_site, PersonalSiteWeb.Endpoint,
  load_from_system_env: true,
  url: [host: "jesperfridefors.se"],
  cache_static_manifest: "priv/static/cache_manifest.json",
  force_ssl: [hsts: true],
  http: [port: 80],
  https: [
    port: 4002,
    otp_app: :personal_site,
    keyfile: "/etc/letsencrypt/live/jesperfridefors.se/privkey.pem",
    cacertfile: "/etc/letsencrypt/live/jesperfridefors.se/chain.pem",
    certfile: "/etc/letsencrypt/live/jesperfridefors.se/cert.pem"
  ]

config :logger, level: :info

import_config "prod.secret.exs"

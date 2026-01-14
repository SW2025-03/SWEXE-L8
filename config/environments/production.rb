require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # コードのリロードは行わない（本番向け）
  config.cache_classes = true
  config.eager_load = true

  # Full error reports を無効化
  config.consider_all_requests_local = false

  # キャッシュ設定
  config.action_controller.perform_caching = true
  config.public_file_server.headers = { "Cache-Control" => "public, max-age=#{1.year.to_i}" }

  # SSL関連の設定（無料版 Render 用）
  config.force_ssl = false
  config.assume_ssl = false

  # セッションストア設定（HTTPS でなくても cookie を保存）
  Rails.application.config.session_store :cookie_store, key: "_unimete_session", secure: false

  # ActionMailer 本番用 URL 設定
  config.action_mailer.default_url_options = { host: ENV["RENDER_EXTERNAL_URL"] || "your-app.onrender.com", protocol: "https" }

  # エラー発生時のメール通知
  # config.action_mailer.raise_delivery_errors = false

  # ログ設定
  config.log_level = :info
  config.log_tags = [:request_id]

  # その他の本番用デフォルト設定
  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.active_record.dump_schema_after_migration = false
end

require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Reload code on every request in development (default: true)
  config.cache_classes = false

  # Enable/disable caching. By default, caching is disabled.
  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    # Cache store settings
    config.cache_store = :memory_store
    config.public_file_server.headers = { "Cache-Control" => "public, max-age=#{2.days.to_i}" }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system.
  config.active_storage.service = :local

  # Devise mailer configuration
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  # Disable delivery errors if you don't want to raise exceptions.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Log query details
  config.active_record.verbose_query_logs = true

  # Log background job enqueue details
  config.active_job.verbose_enqueue_logs = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raise error when a before_action's only/except options reference missing actions.
  config.action_controller.raise_on_missing_callback_actions = true

  # Show full error reports.
  config.consider_all_requests_local = true

  # Disable eager loading in development.
  config.eager_load = false

  # Enable server timing.
  config.server_timing = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.perform_deliveries = true

  config.action_controller.raise_on_missing_callback_actions = true
end

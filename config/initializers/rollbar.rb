Rollbar.configure do |config|
  # Without configuration, Rollbar is enabled in all environments.
  # To disable in specific environments, set config.enabled=false.

  config.access_token = 'e07e2b8aad4d45718f45c58371cf23da'

  # Here we'll disable in 'test':
  if Rails.env.test? || Rails.env.development?
    config.enabled = false
  end

  config.exception_level_filters.merge!('ActionController::RoutingError' => 'ignore')

  config.environment = ENV['ROLLBAR_ENV'].presence || Rails.env
end

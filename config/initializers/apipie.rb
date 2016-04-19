Apipie.configure do |config|
  config.app_name                = "LitmusStatus"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/api"
  config.app_info                = "LitmusStatus API allows to update the service current status."
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end

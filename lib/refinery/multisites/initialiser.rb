require 'apartment'

::Apartment.configure do |config|
  config.tld_length = Refinery::Multisites.tld_length
  config.excluded_models = ["Account"]
  config.tenant_names = -> { Account.pluck(:subdomain) }
end
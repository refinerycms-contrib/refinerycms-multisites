Apartment.configure do |config|
  config.tld_length = Refinery::Multisites.tld_length
  config.excluded_models = ["Refinery::Multisites::Account"]
  config.tenant_names = -> { Refinery::Multisites::Account.pluck(:subdomain) }
  config.persistent_schemas = ['shared_extensions']
end
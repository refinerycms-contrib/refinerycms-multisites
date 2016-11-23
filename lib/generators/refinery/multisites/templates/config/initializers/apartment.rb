Apartment.configure do |config|
  config.tld_length = Refinery::Multisites.tld_length
  
  # If you're grafting onto an existing app, add your User class
  # config.excluded_models = %w( Refinery::Multisites::Account 
  #   Refinery::Authentication::Devise::Role 
  #   Refinery::Authentication::Devise::RolesUsers
  #   Refinery::Authentication::Devise::User 
  #   Refinery::Authentication::Devise::UserPlugin )
  config.excluded_models = %w( Refinery::Multisites::Account )
  
  config.tenant_names = -> { Refinery::Multisites::Account.pluck(:subdomain) }
end
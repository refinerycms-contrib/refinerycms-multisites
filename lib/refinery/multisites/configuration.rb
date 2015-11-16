module Refinery
  module Multisites
	  include ActiveSupport::Configurable

	  config_accessor :tld_length, :restricted_subdomains


	  self.tld_length = 1
	  self.restricted_subdomains = %w(www admin)
	end
end
module Refinery
  module Multisites
	  include ActiveSupport::Configurable

	  config_accessor :single_tenant_mode,
	  				  :tld_length, :restricted_subdomains

	  self.single_tenant_mode = false

	  self.tld_length = 1
	  self.restricted_subdomains = %w(www admin)

	  class << self
      def single_tenant_mode?
        config.single_tenant_mode.present?
      end
    end
	end
end
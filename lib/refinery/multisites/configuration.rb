module Refinery
  module Multisites
	  include ActiveSupport::Configurable

	  config_accessor :tld_length

	  self.tld_length = 1
	end
end
module Refinery
  module Multisites
	  include ActiveSupport::Configurable

	  config_accessor :todo

	  self.todo = false
	end
end
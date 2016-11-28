module Refinery
  module Multisites
	  include ActiveSupport::Configurable

	  config_accessor :single_tenant_mode, :restricted_subdomains

	  self.single_tenant_mode = false
	  self.restricted_subdomains = %w(www admin)

    # User model isn't available when this line gets hit, so we use static methods instead
    @@user_class_name = nil
	  class << self
      def single_tenant_mode?
        config.single_tenant_mode.present?
      end

      def user_class=(class_name)
        if class_name.is_a?(Class)
          raise TypeError, "You can't set user_class to be a class, e.g., User.  Instead, please use a string like 'User'"
        elsif class_name.is_a?(String)
          @@user_class_name = class_name
        else
          raise TypeError, "Invalid type for user_class.  Please use a string like 'User'"
        end
      end

      def user_class
        class_name = @@user_class_name
        begin
          Object.const_get(class_name) if class_name.present?
        rescue NameError
          class_name.constantize
        end
      end
    end

	end
end
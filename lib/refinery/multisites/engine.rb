module Refinery
  module Multisites
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Multisites

      engine_name :refinery_multisites

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "multisites"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.multisites_admin_accounts_path }
          plugin.pathname = root
          plugin.always_allow_access = false
        end
      end

      config.to_prepare do
        byebug
        Refinery::Multisites.attach! if defined?(Refinery::Authentication::Devise::User)
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Multisites)
      end
    end
  end
end
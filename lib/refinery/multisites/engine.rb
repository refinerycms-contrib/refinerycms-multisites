module Refinery
  module Multisites
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Multisites

      engine_name :refinery_multisites

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "multisites"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.multisites_admin_multisites_path }
          plugin.pathname = root
        end
      end

      config.before_configuration do
        require 'refinery/multisites/initialiser'
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Multisites)
      end
    end
  end
end

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

      config.after_initialize do
        Refinery.register_extension(Refinery::Multisites)
      end
    end
  end
end

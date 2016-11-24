require 'refinerycms-core'
require 'apartment'

module Refinery
  autoload :MultisitesGenerator, 'generators/refinery/multisites/multisites_generator'

  module Multisites
    require 'refinery/multisites/engine'
    require 'refinery/multisites/configuration'

    class << self
      attr_writer :root

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join('spec', 'factories').to_s ]
      end

      def attach!
        require 'refinery/authentication/devise/user'
        require 'refinery/multisites/authorisation_manager_decorator'
        
        Refinery::Authentication::Devise::AuthorisationManager.send :prepend, RefineryAuthenticationDeviseAuthorisationManagerDecorator
      end
    end
  end
end

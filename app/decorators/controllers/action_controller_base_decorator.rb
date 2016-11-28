require 'refinery/multisites/configuration'

module RefineryMultisitesActionControllerBaseDecorator
  extend ActiveSupport::Concern

  included do
    protect_from_forgery with: :reset_session
  end

  def self.prepended(base)
    base.prepend_before_action :load_schema, unless: -> { Refinery::Multisites.single_tenant_mode? }
  end

  private

  def self.included(base)
    base.helper_method :current_subdomain, :current_user_owner?
  end

  def current_subdomain
    @current_subdomain ||=
      current_account.subdomain unless Refinery::Multisites.single_tenant_mode?
  end

  def current_user_owner?
    current_account.owner == current_refinery_user unless Refinery::Multisites.single_tenant_mode?
  end

  def current_account(subdomain = request.subdomain)
    @current_account ||= Refinery::Multisites::Account.find_by(subdomain: subdomain)
  end

  def load_schema
    subdomains = request.subdomains

    if subdomains.present?
      tenant = subdomains.first

      if current_account(tenant)
        Apartment::Tenant.switch!(tenant)
      else
        if Apartment.tld_length >= 2
          if subdomains.many?
            redirect_to refinery.root_path(subdomain: subdomains.last)
          else
            Apartment::Tenant.switch!("public")
          end
        else
          redirect_to refinery.root_path(subdomain: false)
        end
      end
    else
      Apartment::Tenant.switch!("public")
    end
  end
end

ActionController::Base.send :prepend, RefineryMultisitesActionControllerBaseDecorator
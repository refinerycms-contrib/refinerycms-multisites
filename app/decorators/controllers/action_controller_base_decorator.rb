require 'refinery/multisites/configuration'

module RefineryMultisitesActionControllerBaseDecoration
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
    current_account.owner == current_user unless Refinery::Multisites.single_tenant_mode?
  end

  def current_account
    @current_account ||= Refinery::Multisites::Account.find_by(subdomain: request.subdomain)
  end

  def load_schema
    Apartment::Tenant.switch!("public")
    return unless request.subdomain.present?

    if current_account
      Apartment::Tenant.switch!(request.subdomain)
    else
      redirect_to root_url(subdomain: false)
    end
  end
end

ActionController::Base.send :prepend, RefineryMultisitesActionControllerBaseDecoration
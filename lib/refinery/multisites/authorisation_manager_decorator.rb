module RefineryAuthenticationDeviseAuthorisationManagerDecorator

  # The user needs the 'refinery' role to access the admin.
  def authenticate!
    current_account = Refinery::Multisites::Account.find_by(subdomain: Apartment::Tenant.current) 

    unless adapter.current_user.has_role?(:superuser) ||
      ( adapter.current_user.has_role?(:refinery) && 
        ( current_account.present? && 
          ( adapter.current_user.account == current_account || adapter.current_user.organization == current_account )
        )
      )
      
      raise Zilch::Authorisation::NotAuthorisedException
    end
    
    adapter.current_user
  end
end
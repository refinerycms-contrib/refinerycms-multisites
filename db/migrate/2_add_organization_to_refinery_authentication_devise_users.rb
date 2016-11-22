class AddOrganizationToRefineryAuthenticationDeviseUsers < ActiveRecord::Migration
  def change
    if !(user_class = Refinery::Multisites.user_class).nil? && defined?(user_class)
      add_column :refinery_authentication_devise_users, :organization_id, :integer
    end
  end
end
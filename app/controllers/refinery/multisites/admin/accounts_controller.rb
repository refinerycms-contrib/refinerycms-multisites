module Refinery
  module Multisites
    module Admin
      class AccountsController < ::Refinery::AdminController

        crudify :'refinery/multisites/account',
                title_attribute: :subdomain,
                order: :subdomain,
                sortable: false

        before_action :find_all_users, only: [:new, :edit, :create, :update]

        def create
          @account = Refinery::Multisites::Account.new(account_params)
          if @account.valid?
            Apartment::Tenant.create(@account.subdomain)
            @account.save
            redirect_to refinery.multisites_admin_accounts_path
          else
            render action: "new"
          end
        end

        def edit
          @current_domain = request.host
        end

        def destroy
          current_account.destroy
          Apartment::Tenant.drop(current_subdomain)
        end

        protected

        def find_all_users
          @users = Refinery::Multisites.user_class.all if !Refinery::Multisites.user_class.nil?
        end

        def account_params
          params.require(:account).permit(permitted_account_params)
        end

        private

        def permitted_account_params
          [
            :subdomain, :owner_id, :user_ids => []
          ]
        end
      end
    end
  end
end
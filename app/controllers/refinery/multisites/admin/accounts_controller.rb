module Refinery
  module Multisites
    module Admin
      class AccountsController < ::Refinery::AdminController

        crudify :'refinery/multisites/account',
                title_attribute: :subdomain,
                order: :subdomain,
                sortable: false

        before_action :find_all_users, only: [:new, :edit, :create, :update]

        def new
          @account = Refinery::Multisites::Account.new
        end

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

        private

        # Only allow a trusted parameter "white list" through.
        def account_params
          params.require(:account).permit(:subdomain, :owner_id)
        end

        protected

        def find_all_users
          @users = Refinery::Multisites.user_class.all if !Refinery::Multisites.user_class.nil?
        end
      end
    end
  end
end

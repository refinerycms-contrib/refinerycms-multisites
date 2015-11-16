module Refinery
  module Multisites
    module Admin
      class AccountsController < ::Refinery::AdminController

        crudify :'refinery/multisites/account',
                :title_attribute => 'subdomain'

        private

        # Only allow a trusted parameter "white list" through.
        def account_params
          params.require(:multisite).permit(:subdomain)
        end
      end
    end
  end
end

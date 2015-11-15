module Refinery
  module Multisites
    module Admin
      class MultisitesController < ::Refinery::AdminController

        crudify :'refinery/multisites/multisite',
                :title_attribute => 'test'

        private

        # Only allow a trusted parameter "white list" through.
        def multisite_params
          params.require(:multisite).permit(:test)
        end
      end
    end
  end
end

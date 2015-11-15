module Refinery
  module Multisites
    class MultisitesController < ::ApplicationController

      before_action :find_all_multisites
      before_action :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @multisite in the line below:
        present(@page)
      end

      def show
        @multisite = Multisite.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @multisite in the line below:
        present(@page)
      end

    protected

      def find_all_multisites
        @multisites = Multisite.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/multisites").first
      end

    end
  end
end

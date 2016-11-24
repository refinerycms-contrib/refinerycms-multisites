require 'acts_as_indexed'

module Refinery
  module Multisites
    class Account < Refinery::Core::BaseModel
      self.table_name = 'refinery_multisites_accounts'

		  before_validation :downcase_subdomain

		  validates :owner_id, presence: true, if: :owner_required?
		  validates :subdomain, presence: true,
		                        uniqueness: { case_sensitive: false },
		                        format:
		                        {
		                          with: /\A[\w\-]+\Z/i,
		                          message: :invalid_characters
		                        },
		                        exclusion:
		                        {
		                          in: Refinery::Multisites.restricted_subdomains,
		                          message: :restricted
		                        }

      belongs_to :owner, proc { readonly(true) }, class_name: Refinery::Multisites.user_class.to_s
      has_many :users, class_name: Refinery::Multisites.user_class.to_s, inverse_of: :organization, foreign_key: :organization_id

      acts_as_indexed :fields => [:subdomain]

      # Override this to disable required owner
      def owner_required?
        !Refinery::Multisites.user_class.nil?
      end

		  private

		  def downcase_subdomain
		    self.subdomain = subdomain.try(:downcase)
		  end
    end
  end
end
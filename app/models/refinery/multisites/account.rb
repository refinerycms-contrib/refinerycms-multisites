module Refinery
  module Multisites
    class Account < Refinery::Core::BaseModel
      self.table_name = 'refinery_multisites_accounts'

      acts_as_indexed :fields => [:subdomain]

		  before_validation :downcase_subdomain

		  validates :owner, presence: true
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

		  belongs_to :owner, class_name: "User"

		  has_many :users, inverse_of: :organization

		  private

		  def downcase_subdomain
		    self.subdomain = subdomain.try(:downcase)
		  end
    end
  end
end
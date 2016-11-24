if !(user_class = Refinery::Multisites.user_class).nil? && defined?(user_class)
  Refinery::Multisites.user_class.class_eval do
    has_one :account, class_name: Refinery::Multisites::Account, foreign_key: "owner_id", inverse_of: :owner
    belongs_to :organization, class_name: Refinery::Multisites::Account, inverse_of: :users
  end
end
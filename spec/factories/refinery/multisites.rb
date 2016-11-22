FactoryGirl.define do
  factory :multisite, :class => Refinery::Multisites::Account do
    sequence(:subdomain) { |n| "refinery-#{n}" }
  end
end
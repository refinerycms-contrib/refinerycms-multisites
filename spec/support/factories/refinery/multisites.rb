
FactoryGirl.define do
  factory :multisite, :class => Refinery::Multisites::Multisite do
    sequence(:test) { |n| "refinery#{n}" }
  end
end


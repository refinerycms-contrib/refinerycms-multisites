require 'spec_helper'

module Refinery
  module Multisites
    describe Account do
      describe "validations", type: :model do
        subject do
          FactoryGirl.create(:multisite,
          :test => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:test) { should == "Refinery CMS" }
      end
    end
  end
end

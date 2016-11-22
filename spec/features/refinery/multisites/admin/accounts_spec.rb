# encoding: utf-8
require "spec_helper"

module Refinery
  module Multisites
    module Admin
      describe Account, type: :feature do
        refinery_login

        describe "multisites list" do
          before do
            FactoryGirl.create(:multisite, :test => "UniqueTitleOne")
            FactoryGirl.create(:multisite, :test => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.multisites_admin_multisites_path
            expect(page).to have_content("UniqueTitleOne")
            expect(page).to have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.multisites_admin_multisites_path

            click_link "Add New Multisite"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Test", :with => "This is a test of the first string field"
              expect { click_button "Save" }.to change(Refinery::Multisites::Multisite, :count).from(0).to(1)

              expect(page).to have_content("'This is a test of the first string field' was successfully added.")
            end
          end

          context "invalid data" do
            it "should fail" do
              expect { click_button "Save" }.not_to change(Refinery::Multisites::Multisite, :count)

              expect(page).to have_content("Test can't be blank")
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:multisite, :test => "UniqueTitle") }

            it "should fail" do
              visit refinery.multisites_admin_multisites_path

              click_link "Add New Multisite"

              fill_in "Test", :with => "UniqueTitle"
              expect { click_button "Save" }.not_to change(Refinery::Multisites::Multisite, :count)

              expect(page).to have_content("There were problems")
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:multisite, :test => "A test") }

          it "should succeed" do
            visit refinery.multisites_admin_multisites_path

            within ".actions" do
              click_link "Edit this multisite"
            end

            fill_in "Test", :with => "A different test"
            click_button "Save"

            expect(page).to have_content("'A different test' was successfully updated.")
            expect(page).not_to have_content("A test")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:multisite, :test => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.multisites_admin_multisites_path

            click_link "Remove this multisite forever"

            expect(page).to have_content("'UniqueTitleOne' was successfully removed.")
            expect(Refinery::Multisites::Multisite.count).to eq(0)
          end
        end

      end
    end
  end
end

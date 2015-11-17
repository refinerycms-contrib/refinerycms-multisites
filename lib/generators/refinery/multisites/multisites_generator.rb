module Refinery
  class MultisitesGenerator < Rails::Generators::Base

    source_root File.expand_path("../templates", __FILE__)

    def generate_multisites_initializer
      template "config/initializers/refinery/multisites.rb.erb", File.join(destination_root, "config", "initializers", "refinery", "multisites.rb")
    end

     def generate_apartment_initializer
      template "config/initializers/apartment.rb", File.join(destination_root, "config", "initializers", "apartment.rb")
    end

    def rake_db
      rake "refinery_multisites:install:migrations"
    end

    def append_load_seed_data
      create_file 'db/seeds.rb' unless File.exists?(File.join(destination_root, 'db', 'seeds.rb'))
      append_file 'db/seeds.rb', :verbose => true do
        <<-EOH

# Added by Refinery CMS Multisites extension
Refinery::Multisites::Engine.load_seed
        EOH
      end
    end
  end
end
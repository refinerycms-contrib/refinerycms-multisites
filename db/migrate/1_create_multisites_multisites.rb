class CreateMultisitesMultisites < ActiveRecord::Migration

  def up
    create_table :refinery_multisites do |t|
      t.string :test
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-multisites"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/multisites/multisites"})
    end

    drop_table :refinery_multisites

  end

end

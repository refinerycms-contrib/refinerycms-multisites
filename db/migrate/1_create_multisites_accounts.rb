class CreateMultisitesAccounts < ActiveRecord::Migration

  def up
    create_table :refinery_multisites_accounts do |t|
      t.string :subdomain, null: false, default: ""
      t.integer :owner_id, null: false, default: 0

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-multisites"})
    end

    drop_table :refinery_multisites_accounts
  end
end
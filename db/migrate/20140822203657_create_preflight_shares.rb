class CreatePreflightShares < ActiveRecord::Migration
  def change
    create_table :preflight_shares do |t|
      t.string :provider, null: false
      t.string :uid
      t.integer :campaign_subscription_id, null: false

      t.timestamps
    end

    add_index :preflight_shares, [:provider, :uid]
    add_index :preflight_shares, :campaign_subscription_id
  end
end

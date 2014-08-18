class CreatePreflightCampaignSubscriptions < ActiveRecord::Migration
  def change
    create_table :preflight_campaign_subscriptions do |t|
      t.integer :subscriber_id, null: false
      t.integer :campaign_id, null: false
      t.integer :referrer_id

      t.timestamps
    end

    add_index :preflight_campaign_subscriptions,
      [:subscriber_id, :campaign_id],
      unique: true,
      name: 'campaign_subscriptions_uniq'
    add_index :preflight_campaign_subscriptions, :referrer_id
  end
end

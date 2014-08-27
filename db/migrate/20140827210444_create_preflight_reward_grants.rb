class CreatePreflightRewardGrants < ActiveRecord::Migration
  def change
    create_table :preflight_reward_grants do |t|
      t.integer :campaign_subscription_id, null: false
      t.integer :reward_id, null: false

      t.timestamps null: false
    end

    add_index :preflight_reward_grants,
      [:campaign_subscription_id, :reward_id],
      name: 'uniq_grant',
      unique: true
    add_index :preflight_reward_grants,
      :campaign_subscription_id
  end
end

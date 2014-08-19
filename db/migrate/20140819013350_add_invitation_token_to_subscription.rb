class AddInvitationTokenToSubscription < ActiveRecord::Migration
  def change
    add_column :preflight_campaign_subscriptions, :invitation_token,
      :string,
      null: false

    add_index :preflight_campaign_subscriptions,
      [:invitation_token, :campaign_id],
      unique: true,
      name: 'invitation_token_uniq'
  end
end

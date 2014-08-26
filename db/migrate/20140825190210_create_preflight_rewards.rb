class CreatePreflightRewards < ActiveRecord::Migration
  def change
    create_table :preflight_rewards do |t|
      t.integer :campaign_id, null: false
      t.string :title, null: false
      t.text :description, null: false
      t.integer :rank, null: false
      t.integer :threshold_units, null: false
      t.string :threshold_type, null: false

      t.timestamps
    end

    add_index :preflight_rewards, :campaign_id
    add_index :preflight_rewards, [:campaign_id, :rank], unique: true
  end
end

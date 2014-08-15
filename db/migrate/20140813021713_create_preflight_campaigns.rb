class CreatePreflightCampaigns < ActiveRecord::Migration
  def change
    create_table :preflight_campaigns do |t|
      t.string :title, null: false
      t.string :cached_slug, null: false
      t.datetime :started_at, null: false
      t.datetime :ended_at
      t.text :description

      t.timestamps
    end

    add_index :preflight_campaigns, :title, unique: true
    add_index :preflight_campaigns, :cached_slug, unique: true
    add_index :preflight_campaigns, [:started_at, :ended_at]
  end
end

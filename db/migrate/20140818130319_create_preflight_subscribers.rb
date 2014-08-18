class CreatePreflightSubscribers < ActiveRecord::Migration
  def change
    create_table :preflight_subscribers do |t|
      t.string :email, null: false
      t.string :ip_address

      t.timestamps
    end

    add_index :preflight_subscribers, :email, unique: true
  end
end

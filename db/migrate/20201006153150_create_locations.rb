class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :org_id
      t.string :user_id
      t.string :cred_id
      t.string :entry_id

      t.timestamps
    end
  end
end

class CreateHouseAdmins < ActiveRecord::Migration
  def change
    create_table :house_admins do |t|
      t.integer :house_id
      t.integer :user_id

      t.timestamps
    end

    add_index :house_admins, :house_id
    add_index :house_admins, :user_id
    add_index :house_admins, [:house_id, :user_id], unique: true
  end
end

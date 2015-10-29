class CreateExpenditures < ActiveRecord::Migration
  def change
    create_table :expenditures do |t|
      t.text :description
      t.string :state
      t.float :value
      t.boolean :to_all
      t.integer :user_id
      t.integer :house_id
      t.datetime :until

      t.timestamps
    end
  end
end

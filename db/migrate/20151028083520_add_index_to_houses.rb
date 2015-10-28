class AddIndexToHouses < ActiveRecord::Migration
  def change
    add_index :houses, [:address, :city], unique: true
  end
end

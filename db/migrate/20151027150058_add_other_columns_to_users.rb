class AddOtherColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :debt, :float
    add_column :users, :house_id, :integer
  end
end

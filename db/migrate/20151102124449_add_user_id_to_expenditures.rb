class AddUserIdToExpenditures < ActiveRecord::Migration
  def change
    add_column :expenditures, :user_id, :integer
    add_index :expenditures, :user_id
  end
end

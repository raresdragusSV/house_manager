class CreateExpenditureUsers < ActiveRecord::Migration
  def change
    create_table :expenditure_users do |t|
        t.integer :expenditure_id
        t.integer :user_id

        t.string :state, default: 'Waiting'
        t.float :debt
        t.timestamps
    end

    add_index :expenditure_users, :expenditure_id
    add_index :expenditure_users, :user_id
    add_index :expenditure_users, [:expenditure_id, :user_id], unique: true
  end
end


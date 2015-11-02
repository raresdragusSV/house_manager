class CreateExpenditureusers < ActiveRecord::Migration
  def change
    create_table :expenditureusers do |t|
        t.integer :expenditure_id
        t.integer :user_id

        t.string :state, default: 'unfinished'
        t.string :request, default: 'waiting'
        t.float :debt
        t.timestamps
    end

    add_index :expenditureusers, :expenditure_id
    add_index :expenditureusers, :user_id
    add_index :expenditureusers, [:expenditure_id, :user_id], unique: true
  end
end

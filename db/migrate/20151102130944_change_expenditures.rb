class ChangeExpenditures < ActiveRecord::Migration
  def up
    change_table :expenditures do |t|
      t.string :state, default: 'unfinished'
    end
    Expenditure.update_all ["state = ?", 'unfinished']
  end
end

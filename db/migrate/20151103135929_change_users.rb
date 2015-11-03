class ChangeUsers < ActiveRecord::Migration
  def up
      change_column :users, :debt, :float, default: 0
    User.update_all ["debt = ?", 0]
  end
end

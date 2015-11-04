
class ExpenditureUser < ActiveRecord::Base
  attr_accessible :expenditure_id, :user_id, :state, :debt

  belongs_to :user, foreign_key: 'user_id'
  belongs_to :expenditure, foreign_key: 'expenditure_id'
end

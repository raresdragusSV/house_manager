class ExpenditureUser < ActiveRecord::Base
  attr_accessible :expenditure_id, :request, :state, :user_id, :value

  belongs_to :expenditure
  belongs_to :user

  validates :expenditure_id, presence: true
  validates :user_id,  presence: true
  validates :request, presence: true
  validates :state, presence: true
  validates :value, presence: true
end

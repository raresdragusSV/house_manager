class Expenditure < ActiveRecord::Base
  attr_accessible :description, :house_id, :state, :to_all, :until, :user_id, :value
  belongs_to :user
  belongs_to :house

  has_many :expenditure_users, foreign_key: 'expenditure_id'
  has_many :users, through: :expenditure_users

  validates :description , presence: true
  validates :house_id, presence: true
  validates :state, presence: true
  validates :to_all, presence: true
  validates :user_id, presence: true
  validates :value, presence: true
end

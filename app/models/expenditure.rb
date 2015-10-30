class Expenditure < ActiveRecord::Base
  attr_accessible :description,
                  :house_id,
                  :state,
                  :to_all,
                  :until,
                  :owner_id,
                  :value,
                  :expenditure_users_attributes

  has_many :expenditure_users, foreign_key: 'expenditure_id'
  has_many :users, through: :expenditure_users

  belongs_to :owner_expenditure, foreign_key: 'owner_id', class_name: 'User'
  belongs_to :house


  accepts_nested_attributes_for :expenditure_users

  validates :description , presence: true
  validates :house_id, presence: true
  validates :state, presence: true
  validates :to_all, presence: true
  validates :owner_id, presence: true
  validates :value, presence: true
end

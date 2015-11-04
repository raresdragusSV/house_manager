# == Schema Information
#
# Table name: expenditures
#
#  id          :integer          primary key
#  description :text
#  value       :float
#  to_all      :boolean
#  house_id    :integer
#  until       :datetime
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  state       :string(255)      default("unfinished")
#

class Expenditure < ActiveRecord::Base
  attr_accessible :description,
                  :house_id,
                  :state,
                  :to_all,
                  :until,
                  :user_id,
                  :value,
                  :expenditure_users_attributes
  # before_save :divide_value
  has_many :expenditure_users, foreign_key: 'expenditure_id'
  has_many :users, through: :expenditure_users

  belongs_to :owner, foreign_key: 'user_id', class_name: 'User'
  belongs_to :house


  accepts_nested_attributes_for :expenditure_users, allow_destroy: true

  validates :description , presence: true
  validates :house_id, presence: true
  validates :state, presence: true
  validates :user_id, presence: true
  validates :value, presence: true

  def divide_value(user)
    self.expenditure_users.each do |eu|
      eu.debt  = self.value / self.expenditure_users.size
      if eu.user == user
        eu.state = 'Paid'
      else
        eu.user.debt = eu.user.debt + eu.debt
        eu.user.save!
      end
      eu.save!
    end
  end
end

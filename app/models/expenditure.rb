class Expenditure < ActiveRecord::Base
  attr_accessible :description,
                  :house_id,
                  :state,
                  :to_all,
                  :until,
                  :user_id,
                  :value,
                  :expenditureusers_attributes
  # before_save :divide_value
  has_many :expenditureusers, foreign_key: 'expenditure_id'
  has_many :users, through: :expenditureusers

  belongs_to :expenditureowner, foreign_key: 'user_id', class_name: 'User'
  belongs_to :house


  accepts_nested_attributes_for :expenditureusers, allow_destroy: true

  validates :description , presence: true
  validates :house_id, presence: true
  validates :state, presence: true
  validates :user_id, presence: true
  validates :value, presence: true

  def divide_value(user)
    self.expenditureusers.each do |eu|
      eu.debt  = self.value / self.expenditureusers.size
      if eu.user == user
        eu.state = 'finished'
        eu.request = 'Payed'
      else
        eu.user.debt = eu.user.debt + eu.debt
        eu.user.save!
      end
      eu.save!
    end
  end
end

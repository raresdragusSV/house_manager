# == Schema Information
#
# Table name: houses
#
#  id         :integer          primary key
#  name       :string(255)
#  address    :string(255)
#  city       :string(255)
#  country    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class House < ActiveRecord::Base
  attr_accessible :address, :city, :country, :name

  has_many :house_admins, foreign_key: 'house_id'
  has_many :users, through: :house_admins

  has_many :users, foreign_key: 'house_id'
  has_many :expenditures

  validates :name, presence: true, length: { maximum: 150 }
  validates :address, presence: true,
                      length: { minimum: 7, maximum: 250 },
                      uniqueness: { scope: :city, case_sensitive: false }
  validates :city, presence: true,
                   length: { maximum: 150 }
  validates :country, presence: true,
                      length: { maximum: 150 }


end

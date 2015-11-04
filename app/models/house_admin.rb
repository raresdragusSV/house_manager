class HouseAdmin < ActiveRecord::Base
  attr_accessible :house_id, :user_id
  belongs_to :house
  belongs_to :users

  validates :house_id, presence: true
  validates :user_id,  presence: true
end

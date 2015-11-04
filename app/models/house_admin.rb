# == Schema Information
#
# Table name: house_admins
#
#  id         :integer          not null, primary key
#  house_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class HouseAdmin < ActiveRecord::Base
  attr_accessible :house_id, :user_id
  belongs_to :house
  belongs_to :users

  validates :house_id, presence: true
  validates :user_id,  presence: true
end

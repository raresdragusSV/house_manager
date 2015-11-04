# == Schema Information
#
# Table name: expenditureusers
#
#  id             :integer          not null, primary key
#  expenditure_id :integer
#  user_id        :integer
#  state          :string(255)      default("unfinished")
#  request        :string(255)      default("waiting")
#  debt           :float
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Expenditureuser < ActiveRecord::Base
  attr_accessible :expenditure_id, :user_id, :state, :request, :debt

  belongs_to :user, foreign_key: 'user_id'
  belongs_to :expenditure, foreign_key: 'expenditure_id'
end

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

require 'spec_helper'

describe Expenditure do
  pending "add some examples to (or delete) #{__FILE__}"
end

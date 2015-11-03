class StaticPagesController < ApplicationController
  def home
    if signed_in? && !current_user.house.nil?
      if current_user.expenditureusers.any?
        @debts = current_user.expenditureusers
      end

      @expenditure = current_user.expenditureowners.build
      current_user.house.users.each do |u|
        @expenditure.expenditureusers.build(user_id: u.id)
      end
    end
  end

  def contact
  end
end

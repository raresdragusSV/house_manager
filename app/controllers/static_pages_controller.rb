class StaticPagesController < ApplicationController
  def home
    if signed_in? && !current_user.house.nil?
      if current_user.expenditure_users.any?
        @debts = current_user.expenditure_users
      end

      @expenditure = current_user.expenditures.build
      current_user.house.users.each do |u|
        @expenditure.expenditure_users.build(user_id: u.id)
      end
    end
  end

  def contact
  end
end

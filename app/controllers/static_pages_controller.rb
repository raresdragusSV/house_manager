class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @expenditure = current_user.owner_expenditures.build
      current_user.house.users.each do |u|
          @expenditure.expenditure_users.build(user_id: u.id)
      end
    end
  end

  def contact
  end
end

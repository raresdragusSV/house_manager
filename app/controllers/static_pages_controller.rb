class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @expenditure = current_user.expenditureowners.build
      @name = []
      current_user.house.users.each do |u|
          @expenditure.expenditureusers.build(user_id: u.id)
          @name << u.name
      end
    end
  end

  def contact
  end
end

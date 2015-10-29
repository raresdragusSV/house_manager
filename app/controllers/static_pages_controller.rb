class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @expenditure = current_user.expenditures.build
      @expenditure_users = @expenditure.expenditure_users.build
    end
  end

  def contact
  end
end

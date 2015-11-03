class ExpendituresController < ApplicationController

  def create
    @expenditure = current_user.expenditureowners.build(params[:expenditure])
    @expenditure.house = current_user.house
    if @expenditure.save
      flash[:success] = 'Expenditure created!'
      @expenditure.divide_value(current_user)
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end
end

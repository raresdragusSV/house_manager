class ExpendituresController < ApplicationController

  def create
    @expenditure = current_user.expenditures.build(params[:expenditure])
    @expenditure.house = current_user.house
    if @expenditure.save
      flash[:success] = 'Expenditure created!'
      @expenditure.divide_value(current_user)
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def show
    @expenditure = Expenditure.find(params[:id])
  end
end

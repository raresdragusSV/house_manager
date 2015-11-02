class ExpendituresController < ApplicationController

  def create
    @expenditure = current_user.expenditureowners.build(params[:expenditure])
    @expenditure.house_id = current_user.house.id
    if @expenditure.save
      flash[:success] = 'Expenditure created!'

      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end
end

class ExpendituresController < ApplicationController

  def create
    @expenditure = current_user.owner_expenditures.build(params[:expenditure])
    @expenditure.state = 'unfinished'
    @expenditure.house_id = current_user.house.id
    @expenditure.save!
    params[:expenditure][:expenditure_users_attributes].each do |k, v|
        @expenditure.expenditure_users.build(
        user_id: v['user_id'].to_i,
        value: @expenditure.value / params[:expenditure][:expenditure_users_attributes].size,
        state: 'unfinished',
        request: 'waiting'
        )

    end
    if @expenditure.save



      flash[:success] = 'Expenditure created!'
      redirect_to root_url
    else
      flash[:danger] = 'Error'
      render 'static_pages/home'
    end
  end
end

class HousesController < ApplicationController

  def new
    @house = House.new
  end

  def create
    @house = current_user.houses.build(params[:house])
    if @house.save
      flash[:success] = 'House Project created!'
      current_user.house_admin!(@house)
      current_user.house_id = @house.id
      current_user.roles=(['admin'])
      current_user.save!
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @users = House.find(params[:id]).users
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

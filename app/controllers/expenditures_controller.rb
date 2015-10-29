class ExpendituresController < ApplicationController

  def create
    @expenditure = current_user.expenditures.build(params[:expenditure])
  end
end

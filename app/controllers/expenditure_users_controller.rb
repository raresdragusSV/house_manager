class ExpenditureUsersController < ApplicationController
  load_and_authorize_resource

  def confirm_payment
    @debt = ExpenditureUser.find(params[:id])
    @debt.state = 'Request sent'
    @debt.save!
    UserMailer.payment_confirmation(@debt, @debt.expenditure.owner).deliver
    flash[:success] = 'Request of payment was sent to the owner of expenditure'
    redirect_to :back
  end

  def confirmation_accepted
    @debt = ExpenditureUser.find(params[:id])
    @debt.state = 'Paid'
    @debt.save!
    if expenditure_finish?
      @debt.expenditure.state = 'finished'
      @debt.expenditure.save!
    end
    @debt.user.debt = @debt.user.debt - @debt.debt
    @debt.user.save!
    flash[:success] = 'Payment accepted'
    redirect_to root_url
  end

  def expenditure_finish?
    expenditure = @debt.expenditure
    state = true
    expenditure.expenditure_users.each do |eu|
      if eu.state == 'Paid'
        next
      else
        state = false
      end
      return state
    end
  end
end

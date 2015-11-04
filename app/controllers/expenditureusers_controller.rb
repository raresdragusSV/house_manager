class ExpenditureusersController < ApplicationController
  def confirm_payment
    @debt = Expenditureuser.find(params[:id])
    @debt.request = 'Request sent'
    @debt.save!
    UserMailer.payment_confirmation(@debt, @debt.expenditure.expenditureowner).deliver
    flash[:success] = 'Request of payment was sent to the owner of expenditure'
    redirect_to :back
  end

  def confirmation_accepted
    @debt = Expenditureuser.find(params[:id])
    @debt.state = 'finished'
    @debt.request = 'Paid'
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
    expenditure.expenditureusers.each do |eu|
      if eu.state == 'finished'
        next
      else
        state = false
      end
      return state
    end
  end
end

class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new
    if @user.roles.empty?
      can :new, User
      can :create, User
      can :confirm, User
    end
    @user.roles.each { |r| send(r) }
  end

  def admin
      can :manage, :all
  end

  def regular
    can :index, User
    can :show, User
    can :edit, User, id: @user.id
    can :update, User, id: @user.id
    can :destroy, User, id: @user.id
    can :confirm_payment, Expenditureuser, user_id: @user.id
    can :confirmation_accepted, Expenditureuser, expenditure: { user_id: @user.id }
  end
end

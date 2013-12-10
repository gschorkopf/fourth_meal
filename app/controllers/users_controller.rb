class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]

  def new
    @user  = User.new
    @restaurants = Restaurant.all
  end

  def create
    @restaurants = Restaurant.all
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver
      current_user.move_to(@user) if is_guest?
      session[:user_id] = @user.id
      redirect_to session[:last_order_page] || orders_path, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def edit
    @restaurants ||= Restaurant.all
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def show
    @restaurants ||= Restaurant.all
  end

  def is_guest?
    current_user && current_user.guest?
  end

private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :full_name, :display_name, :password, :password_confirmation)
  end

end

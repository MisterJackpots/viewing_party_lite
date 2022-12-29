class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    elsif params[:password] != params[:password_confirmation]
      redirect_to register_path
      flash[:alert] = "Error: Password and confirmation must match"
    else
      flash[:alert] = "Error: Email already linked with an account"
      redirect_to register_path
    end
  end

  def login_form

  end

  def login_user
    # require "pry"; binding.pry
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      redirect_to user_path(user)
    else
      redirect_to login_path
      flash[:alert] = "Bad credentials"
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end

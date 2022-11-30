class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to "/users/#{@user.id}"
    else
      render new
    end
  end

  private

  def user_params
    params.permit(:name, :email)
  end
end

class UsersController < ApplicationController
  before_action :require_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:alert] = "Something went wrong"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])

    if current_user == @user
      render :show
    else
      flash[:alert] = "You are not authorized to view this page"
      redirect_to user_path(current_user)
    end  
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end

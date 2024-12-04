class UsersController < ApplicationController
  before_action :require_login

  def index
    @users = User.all
  end

  def show
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: "User updated successfully."
    else
      redirect_to users_path, alert: "Error updating User."
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to users_path, notice: "User deleted successfully."
    else
      redirect_to users_path, alert: "Error deleting User."
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :user_name, :password, :email, :phone, :profile_id)
  end
end

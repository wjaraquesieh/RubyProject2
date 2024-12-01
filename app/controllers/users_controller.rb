class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
  end

  def update
    @user = User.find(params[:id])
    puts @user
    if @user.update(user_params)
      redirect_to users_path, notice: "Category updated successfully."
    else
      redirect_to users_path, alert: "Error updating category."
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :user_name, :password, :email, :phone)
  end
end

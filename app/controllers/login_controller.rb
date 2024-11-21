class LoginController < ApplicationController
  def index
  end

  def register
  end

  def newRegister
    user = User.new(user_params)

    # Set profileId to 2 for normal users
    user.profile_id = current_user&.profile_id == 1 ? params[:user][:profile_id] : 2

    if user.save
      redirect_to login_path, notice: "Account created successfully. Please log in."
    else
      flash.now[:alert] = "There was an error creating your account."
      render :register
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :phone, :password)
  end
end

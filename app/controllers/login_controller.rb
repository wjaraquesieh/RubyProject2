class LoginController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :login ]
  def index
  end

  def register
  end

  def login
    user = User.find_by(user_name: params[:username])
    puts user
    if user && user.password == params[:password]
      # Inicia sesión guardando el ID del usuario en la sesión
      session[:user_id] = user.id
      redirect_to root_path, notice: "Welcome back, #{user.name}!"
    else
      # Muestra un mensaje de error si las credenciales no son válidas
      flash.now[:alert] = "Invalid username or password. Please try again."
      render :index
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to login_path, notice: "You have successfully logged out."
  end

  def newRegister
    user = User.new(user_params)

    # Set profileId to 2 for normal users
    user.profile_id = current_user&.profile_id == 1 ? params[:user][:profile_id] : 2

    # if user.save
    #   redirect_to (logged_in? ? user_path : login_path), notice: "Account created successfully. Please log in."
    # else
    #   flash.now[:alert] = "There was an error creating your account."
    #   render :register
    # end
  end

  private

  def user_params
    params.require(:user).permit(:name, :user_name, :password, :email, :phone)
  end
end

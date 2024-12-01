class ProfilesController < ApplicationController
  def index
    @profiles = Profile.all
                  .page(params[:page]).per(15)
  end

  def create
    unless params[:profiles]
      params[:profiles] = { name: params[:name] }
    end
    @profile = PaymentType.new(profile_params)

    if @profile.save
      redirect_to profiles_path, notice: "Profile created successfully."
    else
      flash.now[:alert] = "There was an error creating the Profile."
      render :index
    end
  end

  def update
    @profile = PaymentType.find(params[:id])

    unless params[:profiles]
      params[:profiles] = { name: params[:name] }
    end

    if @profile.update(profile_params)
      redirect_to profiles_path, notice: "Profile updated successfully."
    else
      flash[:alert] = "Error updating Profile."
      render :index
    end
  end

  def destroy
    @profile = PaymentType.find(params[:id])
    if @profile.destroy
      redirect_to profiles_path, notice: "Profile deleted successfully."
    else
      redirect_to profiles_path, alert: "Error deleting Profile."
    end
  end

  private

  def profile_params
    params.require(:profiles).permit(:name)
  end
end

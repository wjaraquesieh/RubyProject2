class ContactController < ApplicationController
  def index
  end

  def send_message
    @contact_params = contact_params
    ContactMailer.with(contact_params: @contact_params).contact_message.deliver_now

    flash[:notice] = "Thank you for your message! We will get back to you soon."
    redirect_to contact_path
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end

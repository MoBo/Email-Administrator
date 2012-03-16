class ResetPasswordsController < ApplicationController
  def index
    
  end
  
  def create
    @email = Email.find_by_email(params[:email_address])
    if @email and @email.alt_email
      if @email.send_reset_password_instructions
        flash[:notice] = "Email is sent, check you inbox" 
      else
        flash[:error] = "Problem with server, please contact your administrator"   
      end
      redirect_to reset_passwords_path
    else     
      flash[:error] = "Email not found or alternativ email not found"  
      redirect_to reset_passwords_path
    end
  end
  
  def show
    @email = Email.find_by_reset_password_token(params[:id])
  end
  
end
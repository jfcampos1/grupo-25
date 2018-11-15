# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      if user.email_confirmed
        log_in user
        redirect_to user
      else
        flash.now[:error] = 'Please activate your account by following the
        instructions in the account confirmation email you received to proceed'
        render 'new'
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  def callback
    if user == User.from_omniauth(env['omniauth.auth'])
      flash[:success] = 'Signed in by Facebook successfully'
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:error] = "Error while signing in by Facebook. Let's register"
      redirect_to new_user_path
    end
  end
end

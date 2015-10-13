class SessionsController < ApplicationController

  def new
    redirect_to root_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
      flash[:success] = 'You are now logged in.'
    else
      redirect_to login_path
      flash[:danger] = 'Log in error, please try again.'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
    flash[:info] = 'You have logged out.'
  end
end

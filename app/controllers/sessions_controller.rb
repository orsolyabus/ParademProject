class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by email: params[:email]
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:alert] = "welcome back!"
      redirect_to @user 
    else
      flash.now[:alert] = "wrong email or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:alert] = "Signed out!"
    redirect_to new_sessions_path
  end
end

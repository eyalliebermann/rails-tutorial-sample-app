class SessionsController < ApplicationController
  def new
  end

  def create
    email= params[:session][:email].downcase #exception if session not exist
    user= User.find_by(email: email)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "Hey #{user.name}.  You're logged in"
      render 'new'
    else
      flash.now[:danger] = 'Oops. wrong email or password.'
      render 'new'
    end
  end

  def destroy
  end
end
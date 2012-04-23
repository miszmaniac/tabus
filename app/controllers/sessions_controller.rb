# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash[:success] = "Witaj ponownie #{user.name}!"
      redirect_back_or user
    else
      flash.now[:error] = 'Nieprawidłowy login lub hasło' # Not quite right!
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end


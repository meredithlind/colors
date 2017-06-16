class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user]

    if @user.save
       flash[:notice] = 'The User is successfully saved!'
       redirect_to signup_path
    end 
  end
end

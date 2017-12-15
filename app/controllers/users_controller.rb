class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
       flash[:notice] = 'The User is successfully saved!'
       redirect_to signup_path
    end 
  end

  def user_params
    params.require(:user).permit(:full_name, :email, :password)
  end
end

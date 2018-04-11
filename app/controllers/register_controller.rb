class RegisterController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Signup successful."
      redirect_to root_url
      #UserMailer.welcome_email(@user).deliver_now
    else
      flash.now[:danger] = "Invalid email/password combination"
      render "new_user"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

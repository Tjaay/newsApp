class HomepageController < ApplicationController
  include HomepageHelper

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to(news_index_path)
    else
      flash.now[:danger] = "Invalid email/password combination"
      render "index"
    end
  end

  def destroy
    log_out
  end
end

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      flash[:success] = 'ログインしました'
      redirect_to root_path
    else
      flash[:error] = '入力情報に誤りがあります'
      redirect_to login_path
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = 'ログアウトしました'
    redirect_to root_path
  end
end

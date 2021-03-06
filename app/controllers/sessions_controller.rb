class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  def new
    if session[:user_id].present?
      redirect_to tasks_path
    else

    end
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.authority == 1
        # binding.irb
        session[:user_id] = user.id
        redirect_to admin_users_path
      else
        session[:user_id] = user.id
        redirect_to user_path(user.id)
      end
    else
      flash[:danger] = 'ログインに失敗しました'
      render :new
    end
  end
  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end
end

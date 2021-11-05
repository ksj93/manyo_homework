class Admin::UsersController < ApplicationController
  before_action :admin_user
  def index
    @users = User.all

    if params[:appoint_admin]
      @user = User.find(params[:id])
      @user.update_attribute('authority',params[:authority])
      # 後にもっと見る
      # binding.irb
      redirect_to admin_users_path

    else

    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def admin_user
    redirect_to tasks_path,notice:"管理者以外はアクセスできない" unless current_user.authority == 1
  end

end

class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :admin_user, only:[:edit,:update,:destroy]
  def new
    if User.count > 0
      if session[:user_id].present?
        redirect_to user_path(current_user.id)
      else
        @user = User.new
      end
    else
      @user = User.new
    end

  end
  def create
    if current_user.authority ==1
      @user =User.new(user_params)
      if User.find_by(params[:eamil]).email != User.new(params.require(:user).permit(:email)).email
        if @user.save
          redirect_to admin_users_path
        else
          render:new
        end
      else
        render:new
      end
    else
      @user =User.new(user_params)
      if User.count >0
        if User.find_by(params[:eamil]).email != User.new(params.require(:user).permit(:email)).email
          if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user.id)
          else
            render:new
          end
        else
          render:new
        end
      else
        @user.save
        session[:user_id] = @user.id
        redirect_to user_path(@user.id)
      end
    end
  end

  def show
    @user = User.find(params[:id])
    if session[:user_id] == @user.id
    elsif current_user.authority ==1
    else
      redirect_to tasks_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.tasks.destroy_all
    @user.destroy

    redirect_to admin_users_path, notice:"user was successfully destroyed."
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice:"user was successfully updated."
    else
      render:edit
    end
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

class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:index, :statistic, :lib]
  before_action :writer_user,        only: [:statistic]
  before_action :admin_user,         only: [:index]
  before_action :current_user?,      only: [:statistic]

  def index
    @users = User.order(:created_at => :desc).all
  end

  def show
    @user = User.find(params[:id])
  end

  def statistic
    @fictions = @current_user.written_fictions
  end

  def lib
    @fictions = current_user.fictions
  end

  private

  def user_params
    params.require(:user).permit(:surname, :name)
  end

  def current_user?
    unless @current_user.id == params[:id].to_i
      flash[:warning] = t('flash.user.not_current_user')
      redirect_to @current_user
    end
  end
end

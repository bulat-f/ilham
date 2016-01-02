class Admin::AdminController < ApplicationController
  before_action :admin_user?

  private

  def admin_user?
    redirect_to root_path unless user_signed_in? && current_user.admin?
  end
end

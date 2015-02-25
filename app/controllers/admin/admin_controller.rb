class Admin::AdminController < ApplicationController
  before_action :admin_user?

  private

  def admin_user?
    unless user_signed_in? && current_user.admin?
      redirect_to root_path
    end
  end
end

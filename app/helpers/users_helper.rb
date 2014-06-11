module UsersHelper

  def admin_user
    unless current_user.admin?
      flash[:warning] = t('flash.user.not_admin')
      redirect_to @current_user
    end
  end

  def writer_user
    unless current_user.writer?
      flash[:warning] = t('flash.user.not_writer')
      redirect_to @current_user
    end
  end
end

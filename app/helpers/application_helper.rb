module ApplicationHelper

  def full_title(title)
    base = "Ilham"
    if title.blank?
      title = base
    else
      title = base + " | " + title
    end
    return title
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def resource_class
    devise_mapping.to
  end
end

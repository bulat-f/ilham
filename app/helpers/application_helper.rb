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
end

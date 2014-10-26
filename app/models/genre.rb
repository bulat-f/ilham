class Genre < ActiveRecord::Base

  has_many :fictions

  def to_s
    I18n.t("genres.#{self.name}") # May be separate .i18n and .to_s?
  end

  def poetry?
    if self.name == 'poetry'
      true
    else
      false
    end
  end
end

class Genre < ActiveRecord::Base

  has_many :fictions

  def to_s
    I18n.t("genres.#{name}")
  end

  def poetry?
    name == 'poetry'
  end
end

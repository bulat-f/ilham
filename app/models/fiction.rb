class Fiction < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  belongs_to :genre
  has_many   :purchases
  has_many   :readers, through: :purchases
  has_many   :payments
  has_many   :episodes

  mount_uploader :cover, CoverUploader

  def t_genre
    I18n.t("genres.#{self.genre.name}")
  end

  def author_name
    author = self.author
    if author.name.blank? && author.surname.blank?
      author.email
    else
      "#{author.name} #{author.surname}"
    end
  end
end

class Fiction < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  belongs_to :genre
  has_many   :purchases
  has_many   :readers, through: :purchases
  has_many   :payments
  has_many   :episodes

  mount_uploader :cover, CoverUploader

  def self.list(col = 3)
    count = self.count
    result = Array.new(count / col + (count % col != 0 ? 1 : 0)) { Array.new }
    tmp = self.all
    tmp.each_index do |i|
      result[i / col].push(tmp[i])
    end

    return result
  end

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

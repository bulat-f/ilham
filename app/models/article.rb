class Article < ActiveRecord::Base
  mount_uploader :picture, PictureUploader

  validates :title, :description, :body, presence: true

  belongs_to :user
  belongs_to :category

  default_scope { order(created_at: :desc) }

  scope :published,   -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }

  def author
    named = read_attribute(:author)
    if named.blank?
      user.to_s
    else
      named
    end
  end

  def host
    URI.parse(source).host unless source.blank?
  end

  def unpublished
    !published
  end

  def publish
    self.published = true
    save
  end

  def published_at
    updated_at.to_date
  end
end

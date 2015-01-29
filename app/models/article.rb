class Article < ActiveRecord::Base
  mount_uploader :picture, PictureUploader

  belongs_to :user
  belongs_to :category

  default_scope { order(:created_at => :desc) }

  scope :published,   -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }

  def unpublished
    !published
  end

  def publish
    self.published = true
    self.save
  end
end

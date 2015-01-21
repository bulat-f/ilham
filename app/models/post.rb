class Post < ActiveRecord::Base
  mount_uploader :cover, CoverUploader

  has_many :taggings
  has_many :tags, through: :taggings

  default_scope { order(:created_at => :desc) }

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end
end

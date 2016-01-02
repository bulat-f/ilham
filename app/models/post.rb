class Post < ActiveRecord::Base
  mount_uploader :cover, CoverUploader

  has_many :taggings
  has_many :tags, through: :taggings

  default_scope { order(created_at: :desc) }

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def similar(amount = 6)
    target_tags = Tagging.select('post_id').where(tag_id: tags.map(&:id))
    post_list = target_tags.group('post_id').order('count(*) desc').limit(amount + 1).map(&:post_id)
    Post.where('id in (?)', post_list) - [self]
  end
end

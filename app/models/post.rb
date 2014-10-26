class Post < ActiveRecord::Base
  mount_uploader :cover, CoverUploader

  default_scope { order(:created_at => :desc) }
end

class Post < ActiveRecord::Base
  mount_uploader :cover, CoverUploader
end

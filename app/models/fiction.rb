class Fiction < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  belongs_to :genre
  has_many   :purchases
  has_many   :readers, through: :purchases
  has_many   :payments
  has_many   :episodes

  mount_uploader :cover, CoverUploader

  default_scope { order(:created_at => :desc) }
end

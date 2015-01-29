class Fiction < ActiveRecord::Base

  validates :title, :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  belongs_to :author, class_name: "User"
  belongs_to :genre
  has_many   :purchases
  has_many   :readers, through: :purchases
  has_many   :payments
  has_many   :episodes

  mount_uploader :cover, CoverUploader

  default_scope { order(:created_at => :desc) }
end

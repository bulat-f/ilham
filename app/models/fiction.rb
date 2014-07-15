class Fiction < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  belongs_to :genre
  has_many   :purchases
  has_many   :readers, through: :purchases
  has_many   :payments

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
end

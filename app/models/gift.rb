class Gift < ActiveRecord::Base

  belongs_to :presentee, class_name: 'User'
  belongs_to :present,   class_name: 'Fiction'

  has_many :payments, as: :payable

  def pay!
    self[:paid] = true
    self.save!
  end
end

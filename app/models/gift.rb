class Gift < ActiveRecord::Base

  belongs_to :user
  belongs_to :presentee, class_name: 'User'
  belongs_to :present,   class_name: 'Fiction'

  has_many :payments, as: :payable

  def pay!
    self[:paid] = true
    self.save!
  end

  def pay_available_for?(user)
    !paid && self.user == user
  end

  def price
    fiction.price
  end
end

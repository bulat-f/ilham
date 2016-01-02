class Purchase < ActiveRecord::Base
  belongs_to :reader, class_name: 'User'
  belongs_to :fiction

  has_many :payments, as: :payable

  def to_s
    fiction.to_s
  end

  def pay!
    self[:paid] = true
    self.save!
  end

  def pay_available_for?(user)
    !paid && reader == user
  end

  def price
    fiction.price
  end
end

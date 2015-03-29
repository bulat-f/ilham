class Gift < ActiveRecord::Base

  belongs_to :presentee, class_name: 'User'
  belongs_to :present,   class_name: 'Fiction'
  belongs_to :payment

  def pay!
    self[:paid] = true
    self.save!
  end
end

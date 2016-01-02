class Payment < ActiveRecord::Base
  belongs_to :payable, polymorphic: true

  def paid?
    status == 'pay'
  end
end

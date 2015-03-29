class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :fiction

  has_one :gift

  def paid?
    status == 'pay'
  end
end

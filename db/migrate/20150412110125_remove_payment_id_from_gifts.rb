class RemovePaymentIdFromGifts < ActiveRecord::Migration
  def change
    remove_column :gifts, :payment_id, :integer
  end
end

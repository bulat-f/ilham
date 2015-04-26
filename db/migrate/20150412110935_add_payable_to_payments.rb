class AddPayableToPayments < ActiveRecord::Migration
  def change
    remove_column :payments, :fiction_id, :integer
    remove_column :payments, :user_id,    :integer
    add_reference :payments, :payable, polymorphic: true, index: true
  end
end

class AddFictionIdToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :fiction_id, :integer
  end
end

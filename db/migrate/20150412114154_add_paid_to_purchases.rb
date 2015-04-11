class AddPaidToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :paid, :boolean, null: false, default: false
  end
end

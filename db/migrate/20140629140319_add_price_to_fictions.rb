class AddPriceToFictions < ActiveRecord::Migration
  def change
    add_column :fictions, :price, :decimal, precision: 8, scale: 2
  end
end

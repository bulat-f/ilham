class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :reader_id
      t.integer :fiction_id

      t.timestamps
    end
    add_index :purchases, :reader_id
    add_index :purchases, :fiction_id
    add_index :purchases, [:reader_id, :fiction_id], unique: true
  end
end

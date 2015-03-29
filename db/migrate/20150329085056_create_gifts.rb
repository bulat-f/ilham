class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.integer :presentee_id, null: false
      t.integer :present_id,   null: false
      t.integer :payment_id,                default: nil
      t.boolean :paid,         null: false, default: false

      t.timestamps null: false
    end
    add_index :gifts, :presentee_id
    add_index :gifts, [:presentee_id, :present_id], unique: true
  end
end

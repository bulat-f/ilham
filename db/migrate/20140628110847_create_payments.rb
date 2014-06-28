class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :operator
      t.string :paymentType
      t.string :phone, limit: 12
      t.string :sign

      t.decimal :profit, :precision => 10, :scale => 4
      t.decimal :sum,    :precision => 10, :scale => 4

      t.integer :unitpayId
      t.integer :user_id

      t.timestamps
    end

    add_index :payments, :user_id
    add_index :payments, :unitpayId, unique: true
  end
end

class CreateOrderPayments < ActiveRecord::Migration[7.2]
  def change
    create_table :order_payments do |t|
      t.references :order, null: false, foreign_key: true
      t.references :payment_type, null: false, foreign_key: true
      t.string :card_name
      t.string :card_number
      t.date :expiration
      t.string :security_code

      t.timestamps
    end
  end
end

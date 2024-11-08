class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.decimal :total
      t.decimal :taxes
      t.string :email
      t.references :user, null: false, foreign_key: true
      t.references :delivery, null: false, foreign_key: true
      t.references :shipping_address, null: false, foreign_key: true

      t.timestamps
    end
  end
end

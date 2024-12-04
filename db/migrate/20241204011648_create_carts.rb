class CreateCarts < ActiveRecord::Migration[7.2]
  def change
    create_table :carts do |t|
      t.integer :product_id
      t.integer :user_id

      t.timestamps
    end
  end
end

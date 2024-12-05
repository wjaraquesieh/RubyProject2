class CreateShippingAddresses < ActiveRecord::Migration[7.2]
  def change
    create_table :shipping_addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :apartment, null: true
      t.string :city
      t.integer :province_id
      t.string :postal_code
      t.string :country
      t.string :phone

      t.timestamps
    end
  end
end

class CreateShippingAddresses < ActiveRecord::Migration[7.2]
  def change
    create_table :shipping_addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :apartment
      t.string :city
      t.string :province
      t.string :postal_code
      t.string :country
      t.string :phone

      t.timestamps
    end
  end
end

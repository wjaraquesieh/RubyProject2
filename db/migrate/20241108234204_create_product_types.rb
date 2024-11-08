class CreateProductTypes < ActiveRecord::Migration[7.2]
  def change
    create_table :product_types do |t|
      t.string :description

      t.timestamps
    end
  end
end

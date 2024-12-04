class CreateTaxRates < ActiveRecord::Migration[7.2]
  def change
    create_table :tax_rates do |t|
      t.string :currency_code
      t.integer :tax_percentage

      t.timestamps
    end
  end
end

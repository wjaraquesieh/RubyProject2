class CreateOrderStatuses < ActiveRecord::Migration[7.2]
  def change
    create_table :order_statuses do |t|
      t.references :order, null: false, foreign_key: true
      t.references :status, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end

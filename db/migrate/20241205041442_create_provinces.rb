class CreateProvinces < ActiveRecord::Migration[7.2]
  def change
    create_table :provinces do |t|
      t.string :name
      t.decimal :pst, null: true
      t.decimal :gst, null: true
      t.decimal :hst, null: true

      t.timestamps
    end
  end
end

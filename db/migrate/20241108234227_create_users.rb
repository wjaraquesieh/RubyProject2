class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :user_name
      t.string :password
      t.string :email
      t.string :phone
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end

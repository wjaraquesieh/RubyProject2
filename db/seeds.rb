# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'csv'

# Clean all the data
Category.destroy_all
Delivery.destroy_all
PaymentType.destroy_all
ProductType.destroy_all
Profile.destroy_all
Status.destroy_all

# Loop to get the information
CSV.foreach('db/csv/category.csv', headers: true) do |row|
  Category.create(description: row['description'])
end
CSV.foreach('db/csv/delivery.csv', headers: true) do |row|
  Delivery.create(description: row['description'])
end
CSV.foreach('db/csv/paymentType.csv', headers: true) do |row|
  PaymentType.create(name: row['name'])
end
CSV.foreach('db/csv/productType.csv', headers: true) do |row|
  ProductType.create(description: row['description'])
end
CSV.foreach('db/csv/profile.csv', headers: true) do |row|
  Profile.create(name: row['name'])
end
CSV.foreach('db/csv/status.csv', headers: true) do |row|
  Status.create(name: row['name'])
end

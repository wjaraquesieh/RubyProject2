class TaxRate < ApplicationRecord
  validates :tax_percentage, presence: true
  validates :tax_percentage, numericality: { only_integer: true }
end

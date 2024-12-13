class SaleItem < ApplicationRecord
  belongs_to :sale
  belongs_to :product

  # Validaciones
  validates :quantity, 
            presence: true,
            numericality: { 
              only_integer: true, 
              greater_than: 0 
            }
  validates :unit_price, 
            presence: true, 
            numericality: { greater_than: 0 }
end

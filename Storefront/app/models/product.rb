class Product < ApplicationRecord
  # Validaciones
  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :category, presence: true, length: { maximum: 255 }
  
  # Opcional: Validación para la imagen si estás utilizando ActiveStorage
  has_one_attached :image

  scope :available, -> { where('stock > 0') }
end
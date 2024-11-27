class Product < ApplicationRecord
  belongs_to :category

  # Validaciones
  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :category, presence: true
  validate :not_deleted, on: :update
  # Validación para la imagen si estás utilizando ActiveStorage
  has_one_attached :image

  scope :available, -> { where('stock > 0') }

  scope :active, -> { where(deleted_at: nil) }

  def soft_delete
    update_columns(deleted_at: Time.current, stock: 0)
  end

  def self.ransackable_attributes(auth_object = nil)
    super + ['name', 'description']
  end

  def self.ransackable_associations(auth_object = nil)
    super + ['category']
  end


  private

  def not_deleted
    if deleted_at.present?
      errors.add(:base, "El producto ha sido eliminado y no se puede modificar.")
    end
  end

end
class Product < ApplicationRecord
  belongs_to :category
  has_many_attached :images

  # Validaciones
  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :category, presence: true
  validate :not_deleted, on: :update
  validate :images_content_type
  validate :image_count
  validate :ensure_minimum_images, on: :update

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

  def images_content_type
    images.each do |image|
      unless image.content_type.in?(%('image/png image/jpg image/jpeg'))
        errors.add(:images, 'Solo se pueden cargar imágenes en formato PNG, JPG o JPEG')
      end
    end
  end

  def image_count
    # Verifica si hay imágenes adjuntas
    if images.attached?
      # Validar que haya al menos una imagen
      if images.count < 1
        errors.add(:images, "Se requiere al menos una imagen.")
      end
      # Validar que no haya más de 3 imágenes
      if images.count > 3
        errors.add(:images, "No se pueden subir más de 3 imágenes.")
      end
    else
      errors.add(:images, "Se requiere al menos una imagen.")
    end
  end

  def ensure_minimum_images
    # Verifica que el producto tenga al menos una imagen al intentar actualizar
    if images.attached? && images.count.zero?
      errors.add(:images, "El producto debe tener al menos una imagen.")
    end
  end

end
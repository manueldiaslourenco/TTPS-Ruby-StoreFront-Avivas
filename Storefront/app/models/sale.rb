class Sale < ApplicationRecord
  belongs_to :client
  belongs_to :user

  has_many :sale_items, dependent: :destroy
  has_many :products, through: :sale_items

  validates :total_amount, presence: true, numericality: { greater_than: 0 }
  validates :sale_date, presence: true
  validate :must_have_at_least_one_sale_item
  validate :sale_date_cannot_future

  private

  def must_have_at_least_one_sale_item
    if sale_items.empty?
      errors.add(:error, "Debe tener al menos un producto asociado.")
    end
  end
  
  def sale_date_cannot_future
    if sale_date.present? && sale_date > DateTime.now
      errors.add(:error, "No puede ser una fecha futura.")
    end
  end
end

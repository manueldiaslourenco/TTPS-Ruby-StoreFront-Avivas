class Sale < ApplicationRecord
  belongs_to :client
  belongs_to :user

  has_many :sale_items, dependent: :destroy
  has_many :products, through: :sale_items

  validates :total_amount, presence: true, numericality: { greater_than: 0 }
  validates :sale_date, presence: true
  validate :must_have_at_least_one_sale_item

  private

  def must_have_at_least_one_sale_item
    if sale_items.empty?
      errors.add(:sale_items, "debe tener al menos un producto asociado.")
    end
  end
  
end

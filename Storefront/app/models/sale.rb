class Sale < ApplicationRecord
  belongs_to :client
  belongs_to :user

  has_many :sale_items, dependent: :destroy
  has_many :products, through: :sale_items

  validates :total_amount, presence: true, numericality: { greater_than: 0 }
  validates :sale_date, presence: true
  
end

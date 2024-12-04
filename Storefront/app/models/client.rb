class Client < ApplicationRecord
  has_many :sales

  # Validaciones
  validates :dni, presence: true, uniqueness: true
  validates :name, presence: true
  validates :email, presence: true, 
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true
end

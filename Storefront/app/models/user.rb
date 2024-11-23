class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true
  validates :password, password_strength: { min_entropy: 18, min_word_length: 6, use_dictionary: true}
  validates :phone, format: { with: /\A\d{10}\z/, message: "debe tener 10 dígitos" }
end

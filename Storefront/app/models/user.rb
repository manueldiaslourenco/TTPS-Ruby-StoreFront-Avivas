class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: { message: "Este mail ya está en uso." }
  validates :role, presence: true, inclusion: { in: [0, 1, 2] }
  validates :username, presence: true, uniqueness: { message: "Este nombre de usuario ya está en uso." }
  validates :password, confirmation: true, password_strength: { min_entropy: 18, min_word_length: 6, use_dictionary: true}, if: :password_required?
  validates :phone, presence: true, format: { with: /\A\d{10}\z/, message: "El telefono debe tener 10 dígitos" }


  def password_required?
    new_record? || password.present? || password_confirmation.present?
  end

  # Métodos para interpretar los roles
  def admin?
    role == 2
  end

  def manager?
    role == 1
  end

  def employee?
    role == 0
  end

  def soft_delete
    update(deleted_at: Time.current)
  end

  scope :active, -> { where(deleted_at: nil) }

end

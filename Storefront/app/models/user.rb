class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: { message: "Se debe ingresar un mail." }, uniqueness: { message: "Este mail ya está en uso." }, format: { with: URI::MailTo::EMAIL_REGEXP, message: "El formato de mail no es válido." }
  validates :role, presence: { message: "Se debe seleccionar un rol." }, inclusion: { in: [0, 1, 2] }
  validates :username, presence: { message: "Se debe ingresar un nombre de usuario." }, uniqueness: { message: "Este nombre de usuario ya está en uso." }
  validates :password, confirmation: true, password_strength: { message: "La contraseña es demasiado debil.", min_entropy: 16, min_word_length: 6, use_dictionary: true}, if: :password_required?
  validates :phone, presence: { message: "Se debe ingresar un nombre de usuario." }, format: { with: /\A\d{10}\z/, message: "El telefono debe tener 10 dígitos" }


  def password_required?
    new_record? || password.present? || password_confirmation.present?
  end

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

class Client < ApplicationRecord
  has_many :sales

  validates :dni, presence: { message: "Se debe ingresar un dni." }, uniqueness: true, format: { with: /\A\d{8,10}\z/, message: "El DNI debe tener entre 8 y 10 dígitos"}
  validates :name, presence: { message: "Se debe ingresar un nombre." }
  validates :email, presence: { message: "Se debe ingresar un mail." }, 
            format: { with: URI::MailTo::EMAIL_REGEXP, message: "El formato de mail no es válido" }
  validates :phone, presence: { message: "Se debe ingresar un telefono." }, format: { with: /\A\d{10}\z/, message: "El telefono debe tener 10 dígitos." }
end

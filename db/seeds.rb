# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

    ["Accesorios","Camisetas Deportivas", "Remeras", "Pantalones", "Shorts", "Interior", "Zapatillas", "Botines", "Abrigo", "Conjuntos"].each do |category_name|
      Category.find_or_create_by!(name: category_name)
    end


    require_relative 'seeds/users/create_users'
    require_relative 'seeds/products/helpers'
    require_relative 'seeds/products/create_products'
    require_relative 'seeds/sales/create_sales'
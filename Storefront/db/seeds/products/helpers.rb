def create_product_with_images(name:, description:, price:, stock:, size:, color:, category:)

  product = Product.new(
    name: name,
    description: description,
    price: price,
    stock: stock,
    category: category,
    size: size,
    color: color
  )

  attach_images_from_folder(product, name)

  if product.save
    Rails.logger.info("Producto #{product.name} creado exitosamente.")
  else
    Rails.logger.error("Error al crear el producto #{product.name}.")
  end
end

def attach_images_from_folder(product, folder_name)
  image_folder = Rails.root.join('db', 'seeds', 'products', 'images', folder_name)

  if Dir.exist?(image_folder)
    Dir.glob("#{image_folder}/*.{jpg,png,jpeg}").each do |image_path|
      product.images.attach(io: File.open(image_path), filename: File.basename(image_path))
    end
  else
    Rails.logger.error("Carpeta no encontrada: #{image_folder}. No se adjuntaron imágenes.")
  end
end
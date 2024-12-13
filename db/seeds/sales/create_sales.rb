require 'active_support/all'

client = Client.find_or_create_by!(dni: '45913067') do |c|
  c.name = 'Manuel'
  c.email = 'manueldiasuala@gmail.com'
  c.phone = '2216081818'
end



15.times do

  user = User.first

  # Seleccionar entre 1 y 3 productos con stock disponible
  selected_products = Product.available.sample(rand(1..3))

  # Inicializar detalles de la venta
  total_price = 0
  sale_items = []

  selected_products.each do |product|
    # Determinar una cantidad aleatoria (limitada al stock disponible)

    # Verificar que haya stock suficiente (al menos 1 producto disponible)
    next if product.stock <= 1

    quantity = rand(1..(product.stock - 1))

    # Solo agregar productos con stock suficiente
    next if quantity.zero?

    # Actualizar el precio total de la venta
    total_price += product.price * quantity

    # Agregar detalles del producto a los ítems de la venta
    sale_items << { product: product, quantity: quantity }
  end

  # Crear la venta solo si tiene al menos un producto válido
  next if sale_items.empty?

  # Crear la venta dentro de una transacción
  ActiveRecord::Base.transaction do
    # Crear la venta con el cliente y el usuario asociados

    sale = Sale.new(
      client: client,
      user: user,
      sale_date: rand(1..16).days.ago.change(hour: 16, min: 0, sec: 0),
      total_amount: total_price
    )

    # Inicializar los sale_items antes de guardar la venta
    @sale_items_objects = []

    sale_items.each do |item|
      @sale_items_objects << SaleItem.new(
        sale: @sale,
        product: item[:product],
        quantity: item[:quantity],
        unit_price: item[:product].price
      )

      # Reducir el stock del producto
      item[:product].update!(stock: item[:product].stock - item[:quantity])
    end

    sale.sale_items = @sale_items_objects

    sale.save
  end
end


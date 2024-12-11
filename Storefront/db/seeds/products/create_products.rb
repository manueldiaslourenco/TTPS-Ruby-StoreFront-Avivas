products_data = {
  "Botines" => [
    {name: "Nike Phantom GX ELITE PRO", description: "Botines de Pasto Natural Unisex FG.", price: 299999.99, stock: 50, size: "43", color: "Azul furia/Blanco"},
    {name: 'Nike Phantom GX 2 Elite Erling Haaland Force9', description: "Botines de Pasto Natural Unisex FG.", price: 472999.99, stock: 10, size: "42.5", color: "Carmesí brillante/Blanco"}
  ],
  "Zapatillas" => [
    {name: "Adidas Campus 00s", description: "Una reinterpretación contemporánea de un diseño icónico de los 80, esta zapatilla presenta una parte superior de piel suave, detalles de ante y una suela de goma tan retro como actual.", price: 179999, stock: 64, size: "41.5", color: "Marron/Negro"}
  ],
  "Camisetas Deportivas" => [
    {name: "Golden State Warriors Association Edition 22-23", description: "Musculosa de Basquet para Hombre.", price: 159999, stock: 59, size: "M", color: "Blanco"},
    {name: "Camiseta Local Atletico Madrid 23-24", description: "Camiseta de Fútbol para Hombre.", price: 116999, stock: 33, size: "L", color: "Rojo/Blanco"},
    {name: "Camiseta Estudiantes De La Plata Titular Ruge 22", description: "Las mangas son dominadas por el rojo, con un bastón blanco al frente y otro atrás, bastones rojiblancos en la titular y vivos negros en el posterior del cuello.", price: 59999, stock: 7, size: "M", color: "Rojo/Blanco"}
  ],
  "Accesorios" => [
    {name: "Gorra New York Yankees MLB Farm Team 59FIFTY Cerrada", description:"Esta gorra New Era 59FIFTY de New York Yankees de la colección MLB Farm Team presenta el logo de los Yankees bordado en los paneles frontales y el de su equipo de la MiLB en la parte trasera, además del logo de MLB y MiLB en la parte derecha.", price:65999, stock: 5, size: nil, color: nil},
    {name: "Gorra New Era Miami Heat White Crown Team 9FIFTY", description:"¡Un clásico retro y ajustable! La 9FIFTY es una gorra estructurada de corona alta, está hecha con seis paneles y tiene una visera plana que podes doblar a tu gusto. Los paneles traseros se abren y ajustan mediante un snapback o strapback.", price:54999, stock: 0, size: nil, color: "Blanco/Rojo"},
    {name: "Gorra New Era BIZARRAP 9FORTY Ajustable", description: "Bizarrap y New Era se unen para crear la gorra Oficial de BZRP, una gorra de la mejor calidad llena de detalles únicos, como el bordado de BzRP ORIGINAL en el interior.", price: 56999, stock: 0, size: nil, color: "Negro/Amarillo"}
  ],
  "Shorts" => [
    {name: "Short Ruge Visitante Estudiantes De La Plata 23", description: "Short Ruge Visitante Estudiantes De La Plata Tempoorada 2023.", price: 17999, stock: 12, size: "S", color: "Rojo" }
  ]
}

products_data.each do |category_name, products|

  category = Category.find_by(name: category_name)
  
  products.each do |product_params|
    create_product_with_images(
      name: product_params[:name],
      description: product_params[:description],
      price: product_params[:price],
      stock: product_params[:stock],
      size: product_params[:size],
      color: product_params[:color],
      category: category
    )
  end
end
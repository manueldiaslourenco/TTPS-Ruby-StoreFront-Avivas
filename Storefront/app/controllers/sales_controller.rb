class SalesController < ApplicationController
  before_action :set_sale, only: %i[show]
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @sales = Sale.all.page(params[:page])
  end

  def show
    @products = @sale.products
    @client = @sale.client
  end

  def new
    @products= Product.active.available
    @client = {
      dni: params[:dni],
      name: params[:name],
      phone: params[:phone],
      email: params[:email]
    }
    @selected_products = session[:selected_products] || []
  end
  
  def update_products_list
    session[:selected_products] ||= []
  
    product_id = params[:product_id].to_i
    quantity = params[:quantity].to_i
  
    # Verificar que el product_id y la cantidad son válidos
    if product_id > 0 && quantity > 0
      product = Product.find_by(id: product_id)
  
      if product

        existing_product = session[:selected_products].detect { |p| p['id'] == product_id }

        if existing_product
          # Si el producto ya existe, sumar la cantidad
          if product.stock - (existing_product['quantity'] + quantity) > 0
            existing_product['quantity'] += quantity
          else
            flash[:error] = "La cantidad seleccionada supera el stock disponible."
          end
        else
          # Si el producto no está en la lista, agregarlo
          if product.stock - quantity > 0
            session[:selected_products] << { id: product.id, name: product.name, quantity: quantity, stock_available: product.stock }
          else
            flash.now[:error] = "La cantidad seleccionada supera el stock disponible."
          end
        end
      else
        flash.now[:error] = "Producto no encontrado"
      end
    else
      flash.now[:error] = "El Producto o la cantidad ingresada no es válida"
    end
  
    redirect_to new_sale_path
  end

  def clear_selected_products
    session[:selected_products] = []
    redirect_to new_sale_path
  end
  
  def create
    ActiveRecord::Base.transaction do
      client_params = params[:sale].slice(:dni, :name, :phone, :email)
      
      @sale = Sale.new(sale_params)
      @sale.user = current_user

      # Verificar o crear el cliente
      @sale.client = find_or_create_client!(client_params)
      sale_date_clock = sale_params[:sale_date]
      sale_date_object = DateTime.parse(sale_date_clock)
      @sale.sale_date = sale_date_object
      
      
      # Validar y procesar productos seleccionados
      if session[:selected_products].present?
        process_products!(session[:selected_products])
        calculate_total_amount!
        @sale.save!
        session[:selected_products] = []
        flash[:success] = "Venta creada exitosamente."
        redirect_to sale_path(@sale)
      else
        flash.now[:error] = "No se seleccionaron productos para la venta."
        @products= Product.active.available
        @client = {
          dni: params[:dni],
          name: params[:name],
          phone: params[:phone],
          email: params[:email]
        }
        @selected_products = session[:selected_products] || []
        render :new and raise ActiveRecord::Rollback
      end
    end
  end

  def destroy
    @sale = Sale.find(params[:id])
  
    if @sale.deleted_at.present?
      flash[:error] = "Esta venta ya ha sido cancelada."
      redirect_to sale_path(@sale) and return
    end
  
    ActiveRecord::Base.transaction do
      @sale.update!(deleted_at: DateTime.now)
  
      @sale.sale_items.each do |sale_item|
        product = sale_item.product
        product.update!(stock: product.stock + sale_item.quantity)
      end
    end
  
    flash[:success] = "Venta cancelada y stock restaurado."
    redirect_to sale_path(@sale)
  end


  private

  def set_sale
    @sale = Sale.find(params[:id])
  end

  # Método para encontrar o crear un cliente
  def find_or_create_client!(params)
    @client = Client.find_or_initialize_by(dni: params[:dni])
    
    @client.assign_attributes(
      name: params[:name],
      phone: params[:phone],
      email: params[:email]
    )

    @client.save! if @client.new_record? || @client.changed?
  
    @client
  end

  def process_products!(selected_products)
    @sale_items = []

    selected_products.each do |product_data|
      product = Product.find(product_data['id'])
      
      if product.stock < product_data['quantity']
        raise ActiveRecord::Rollback, "Stock insuficiente para #{product.name}"
      end

      product.update!(stock: product.stock - product_data['quantity'])

      @sale_items << SaleItem.new(
        sale: @sale,
        product: product,
        quantity: product_data['quantity'],
        unit_price: product.price
      )
    end

    @sale.sale_items = @sale_items
  end

  def calculate_total_amount!
    total = @sale.sale_items.sum { |item| item.quantity * item.unit_price }
    @sale.total_amount = total
  end

  def sale_params
    params.require(:sale).permit(:client_id, :sale_date, :quantity)
  end
end

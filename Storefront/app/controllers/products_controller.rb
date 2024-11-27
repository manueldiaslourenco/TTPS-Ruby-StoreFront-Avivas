class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :update_stock, :destroy]

  # GET /products
  def index
    @products = Product.active
  end

  # GET /products/:id
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # POST /products
  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: 'El producto fue creado exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /products/:id/edit
  def edit
  end

  # PATCH/PUT /products/:id
  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'El producto fue actualizado exitosamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update_stock

    if @product.update(stock_params)
      redirect_to @product, notice: 'Stock actualizado exitosamente.'
    else
      render :show
    end
  end

  def destroy
    if @product.soft_delete
      flash[:notice] = "Producto eliminado con éxito."
    else
      flash[:alert] = "No se pudo eliminar el producto."
    end
    redirect_to products_path
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :category_id, :size, :color, :image)
  end

  def stock_params
    params.require(:product).permit(:stock)
  end
end

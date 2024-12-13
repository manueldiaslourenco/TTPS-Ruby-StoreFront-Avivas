class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_product, only: [:show, :edit, :update, :update_stock, :destroy]
  load_and_authorize_resource

  # GET /products
  def index
    @query = Product.ransack(params[:q])
    @products = @query.result.includes(:category).active.page(params[:page])
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
    @product = Product.new(product_params.except(:remove_images))
    if @product.save
      redirect_to @product, notice: 'El producto fue creado exitosamente.'
    else
      flash_messages_from_model(@product)
      render :new, status: :unprocessable_entity
    end
  end

  # GET /products/:id/edit
  def edit
  end

  def update
    ActiveRecord::Base.transaction do
      # Validar que no se eliminen todas las imágenes sin agregar nuevas
      if params[:product][:remove_images].present?
        remaining_images = @product.images.count - params[:product][:remove_images].size
        new_images = params[:product][:images].present? && params[:product][:images].reject(&:blank?).any?
        
        if remaining_images.zero? && !new_images
          begin
          raise ActiveRecord::Rollback
          rescue ActiveRecord::Rollback => e
            flash.now[:error] = "No puedes eliminar todas las imágenes sin agregar al menos una nueva."
            render :edit, status: :unprocessable_entity # Si hay errores de validación, renderizas
            return # Añades return para evitar que se ejecute el siguiente código
          end
        else
          # Proceder a eliminar las imágenes marcadas
          params[:product][:remove_images].each do |image_id|
            @product.images.find(image_id).purge
          end
        end
      end

      if params[:product][:images].present?
        new_images = params[:product][:images].reject(&:blank?)
        @product.images.attach(new_images)
      end
      # Intentar actualizar el producto con nuevos datos
      if @product.update(product_params.except(:remove_images, :images))
        flash[:success] = "El producto se actualizó correctamente."
        redirect_to @product, success: 'El producto se actualizó correctamente.'
      else
        raise ActiveRecord::Rollback
      end
  
    end

    if @product.errors.any?
      flash_messages_from_model(@product)
      render :edit, status: :unprocessable_entity
    end

  end
  

  def update_stock
    
    if @product.update(stock_params)
      flash[:success] = "Stock actualizado."
      redirect_to @product, success: 'Stock actualizado exitosamente.'
    else
      flash.now[:error] = "No se pudo actualizar el stock."
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.soft_delete
      flash[:success] = "Producto eliminado con éxito."
    else
      flash[:error] = "No se pudo eliminar el producto."
    end
    redirect_to products_path
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :category_id, :size, :color, images: [], remove_images: [])
  end

  def stock_params
    params.require(:product).permit(:stock)
  end
end

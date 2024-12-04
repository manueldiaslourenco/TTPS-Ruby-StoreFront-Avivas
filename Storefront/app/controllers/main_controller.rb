class MainController < ApplicationController

  def index
    @query = Product.ransack(params[:q])
    @products = @query.result.includes(:category).available.page(params[:page])
  end
end

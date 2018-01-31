class ProductsController < ApplicationController

  def index
    @products_result = ProductsDatatable.new(params)
  end

  def show
    @product = Product.where(id: params[:id]).last
  end
end
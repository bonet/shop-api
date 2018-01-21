class ProductsController < ApplicationController

  def index
    render json: ProductsDatatable.new(params).as_json
  end

  def show
    render json: Product.where(id: params[:id]).last
  end
end
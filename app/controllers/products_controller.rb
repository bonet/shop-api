class ProductsController < ApplicationController

  def index
    render json: ProductsDatatable.new(params).as_json
  end
end
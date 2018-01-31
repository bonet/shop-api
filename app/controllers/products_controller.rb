class ProductsController < ApplicationController

  after_action {set_api_cache_key(:api_cache_key)}

  def index
    @products_result = ProductsDatatable.new(params)
    @api_cache_key = collection_cache_key(@products_result.data)

    fresh_when(etag: @api_cache_key)

    params.permit(:category, :price_range, :start_page, :page_length, :order_by, :sort_direction)
  end

  def show
    @product = Product.where(id: params[:id]).last
    @api_cache_key = cache_key @product

    fresh_when(etag: @api_cache_key)
  end
end
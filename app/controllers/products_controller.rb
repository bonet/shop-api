class ProductsController < ApplicationController

  def index
    products = Product.order(sanitized_ordering).
                       page(params[:page]).per(params[:per_page])

    hash_data = { recordsTotal: products.total_count, 
                  recordsFiltered: products.total_count,
                  data: products
                }

    render json: hash_data
  end
end
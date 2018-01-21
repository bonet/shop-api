class ProductsDatatable
  include ActionView::Helpers::UrlHelper

  def initialize(params)
    @params = params
  end

  def as_json(options = {})
    {
      recordsTotal: Product.count,
      recordsFiltered: products.total_entries,
      data: data.to_a
    }
  end

private

  def data
    products
  end

  def products
    @products ||= fetch_products
  end

  def fetch_products
    get_products
    filter_products_by_category
    filter_products_by_price_range
    @products
  end

  def page
    @params[:start_page]
  end

  def per_page
    @params[:page_length].to_i > 0 ? @params[:page_length].to_i : 10
  end

  def sort_column
    @params[:order_by]
  end

  def sort_direction
    if sort_column.present?
      @params[:sort_direction] == "desc" ? "desc" : "asc"
    end
  end

  def order_by_text
    "#{sort_column} #{sort_direction}"
  end

  def get_products
    @products = Product.order(order_by_text)
    @products = @products.page(page).per_page(per_page)
  end

  def filter_products_by_category
    if @params[:category].present?
      @products = @products.where("category = :category", 
                                  category: @params[:category])
    end
  end

  def filter_products_by_price_range
    if @params[:price_range].present?
      price_range = @params[:price_range].split("..")
      @products = @products.where("price BETWEEN :price_start AND :price_end", 
                                  price_start: price_range[0], 
                                  price_end: price_range[1])
    end
  end
end
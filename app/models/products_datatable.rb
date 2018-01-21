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
    filter_products
    @products
  end

  def page
    @params[:start_page]
  end

  def per_page
    @params[:page_length].to_i > 0 ? @params[:page_length].to_i : 10
  end

  def sort_column
    columns = %w[name category price]
    columns[@params[:order_by].to_i]
  end

  def sort_direction
    @params[:sort_direction] == "desc" ? "desc" : "asc"
  end

  def get_products
    @products = Product.order("#{sort_column} #{sort_direction}")
    @products = products.page(page).per_page(per_page)
  end

  def filter_products
    if @params[:search_category].present? && search_query.present?
      @products = products.where(search_query, search_term: "%#{@params[:search_term]}%")
    end
  end

  def search_query
    if @params[:search_category] == "category"
      "category like :search_term" 
    elsif @params[:search_category] == "price"

    end
  end
end
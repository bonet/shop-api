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
    products = Product.order("#{sort_column} #{sort_direction}")
    products = products.page(page).per_page(per_page)
    if @params[:search].present?
      products = products.where("name like :search or category like :search", search: "%#{@params[:search]}%")
    end
    products
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
end
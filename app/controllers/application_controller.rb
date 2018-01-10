class ApplicationController < ActionController::API

  def sanitized_ordering
    "#{sanitize_column(params[:order_by])} #{sanitize_column_direction(params[:sort_direction])}"
  end

  private
  def sanitize_column(column)
    resource.column_names.include?(column) ? column : "created_at"
  end

  def sanitize_column_direction(direction)
    direction = direction.try(:upcase)
    ['DESC', 'ASC'].include?(direction) ? direction : "DESC"
  end

  def resource
    controller_name.camelize.singularize.safe_constantize
  end
end

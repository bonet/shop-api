json.recordsTotal     products_result.records_total
json.recordsFiltered  products_result.records_filtered
json.data do
  json.partial! 'products/products', products: products_result.data
end
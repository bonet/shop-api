require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe "GET index json" do
    it "returns correct basic product data" do
      product_1 = create(:product, category: "books", sold_out: false, under_sale: false)
      product_2 = create(:product, category: "shoes", sold_out: false, under_sale: true)
      products = Product.order("price DESC").map(&:attributes)

      @request.headers['HTTP_ACCEPT'] = 'application/json'
      get :index, params: { order_by: :price }

      parsed_body = JSON.parse(response.body)
      
      expect(response.status).to eq 200
      expect(parsed_body["data"]).to eq products
      expect(parsed_body["recordsTotal"]).to eq products.count
      expect(parsed_body["recordsFiltered"]).to eq products.count
    end
  end
end
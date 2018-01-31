require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  render_views

  describe "GET index json" do
    it "returns correct basic product data" do
      product_1 = create(:product, category: "books", sold_out: false, under_sale: false)
      product_2 = create(:product, category: "shoes", sold_out: false, under_sale: true)
      products  = Product.where(category: "shoes").order("price DESC").select(:id, :name, 
                    :sold_out, :category, :under_sale, :price, :sale_price, :sale_text).as_json

      @request.headers['HTTP_ACCEPT'] = 'application/json'
      get :index, params: { order_by: :price, category: "shoes"}

      parsed_body = JSON.parse(response.body)
      prods = parsed_body["data"]
      expect(products).to eq prods
      expect(response.status).to eq 200
      expect(parsed_body["recordsTotal"]).to eq Product.count
      expect(parsed_body["recordsFiltered"]).to eq products.count
    end
  end

  describe "GET show json" do
    it "returns correct basic product data" do
      product_1 = create(:product, category: "books", sold_out: false, under_sale: false).
                    attributes.except!("created_at", "updated_at")
      product_2 = create(:product, category: "shoes", sold_out: false, under_sale: true).
                    attributes.except!("created_at", "updated_at")

      @request.headers['HTTP_ACCEPT'] = 'application/json'
      get :show, params: { id: product_1["id"] }

      product = JSON.parse(response.body)
      
      expect(response.status).to eq 200
      expect(product).to eq product_1.as_json
    end
  end
end
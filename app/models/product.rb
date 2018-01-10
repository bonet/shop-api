class Product < ApplicationRecord
  validates :name, :category, presence: true
  validates :sold_out, :under_sale, inclusion: { in: [ true, false ] }
  validates :price, numericality: { only_integer: true, 
                                    greater_than_or_equal_to: 0 }, 
                    allow_nil: false
  validates :sale_price, numericality: { only_integer: true, 
                                         greater_than_or_equal_to: 0 }, 
                         allow_nil: true
end
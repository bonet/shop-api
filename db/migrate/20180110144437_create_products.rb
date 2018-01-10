class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string    :name
      t.boolean   :sold_out
      t.string    :category
      t.boolean   :under_sale
      t.integer   :price
      t.integer   :sale_price
      t.string    :sale_text
    end

    add_index :products, :category
    add_index :products, :price
  end
end
class AddTimestampToProducts < ActiveRecord::Migration[5.1]
  def change
    add_timestamps :products
  end
end

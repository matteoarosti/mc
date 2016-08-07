class CreateOrderRows < ActiveRecord::Migration
  def change
    create_table :order_rows do |t|

      t.belongs_to :order
      t.string      :mc_transaction
      t.string      :mc_item
      t.string      :mc_title

      t.integer     :qty
      t.decimal     :price, precision: 7, scale: 2      
      
      t.belongs_to  :product
      t.belongs_to  :product_mc
      t.belongs_to  :product_variation
      t.belongs_to  :product_variation_mc
      
      t.timestamps
    end
  end
end

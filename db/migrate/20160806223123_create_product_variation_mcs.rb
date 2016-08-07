class CreateProductVariationMcs < ActiveRecord::Migration
  def change
    create_table :product_variation_mcs do |t|

      t.belongs_to      :product_mc
      t.string          :variation_string
      t.string          :name
      
      t.belongs_to      :product_variation
      
      t.timestamps
    end
  end
end

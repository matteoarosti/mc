class CreateProductMcs < ActiveRecord::Migration
  def change
    create_table :product_mcs do |t|

      t.belongs_to    :channel
      t.belongs_to    :product
      t.string        :mc_id    #identificativo articoli nel channel (es: item in ebay)
      t.string        :name
      
      t.timestamps
    end
  end
end

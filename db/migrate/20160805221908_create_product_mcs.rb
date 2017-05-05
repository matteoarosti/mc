class CreateProductMcs < ActiveRecord::Migration
  def change
    create_table :product_mcs do |t|

      t.belongs_to    :channel
      t.belongs_to    :product
      t.string        :mc_id    #identificativo articoli nel channel (es: item in ebay)
      t.string        :name
      
      t.integer     :num_impressions      
      t.integer     :num_visits
      t.integer     :num_solded
      t.integer     :num_questions
      t.integer     :num_follows

      t.string      :category_name,   :limit=>200
      t.string      :category_name_1, :limit=>50
      t.string      :category_name_2, :limit=>50
      t.string      :category_name_3, :limit=>50
      t.string      :category_name_4, :limit=>50
      t.string      :category_name_5, :limit=>50
      t.string      :category_name_6, :limit=>50
      t.string      :category_name_7, :limit=>50

      
      t.timestamps
    end
  end
end

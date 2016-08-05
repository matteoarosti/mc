class CreateEbayInsertions < ActiveRecord::Migration
  def change
    create_table :ebay_insertions do |t|

      t.string      :ebay_id,       :limit=>20
      t.string      :title,         :limit=>100
      t.string      :category_name, :limit=>200
      t.string      :category_name_1, :limit=>50
      t.string      :category_name_2, :limit=>50
      t.string      :category_name_3, :limit=>50
      t.string      :category_name_4, :limit=>50
      t.string      :category_name_5, :limit=>50
      t.string      :created_from,  :limit=>'10'    #es: Manuale, Prestashop
      t.decimal     :price,          precision: 10, scale: 2
      t.decimal     :shipping_cost,  precision: 10, scale: 2
      t.date        :start_date
      t.integer     :num_impressions      
      t.integer     :num_visits
      t.integer     :num_solded
      t.integer     :num_questions
      t.integer     :num_follows
      
      t.timestamps
    end
  end
end

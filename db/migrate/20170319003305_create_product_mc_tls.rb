class CreateProductMcTls < ActiveRecord::Migration
  def change
    create_table :product_mc_tls do |t|
            
      t.belongs_to  :product_mc
      t.date        :tl_date
      t.integer     :tl_num_impressions      
      t.integer     :tl_num_visits
      t.integer     :tl_num_transactions
      t.integer     :tl_num_solded
      t.integer     :tl_num_questions
      t.integer     :tl_num_follows     

      t.timestamps
    end
  end
end

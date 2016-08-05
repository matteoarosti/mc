class CreateEbayInsertionTimelines < ActiveRecord::Migration
  def change
    create_table :ebay_insertion_timelines do |t|

      t.belongs_to  :ebay_insertion
      t.integer     :tm_num_impressions      
      t.integer     :tm_num_visits
      t.integer     :tm_num_solded
      t.integer     :tm_num_questions
      t.integer     :tm_num_follows      
      
      t.timestamps
    end
  end
end

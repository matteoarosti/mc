class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|

      t.belongs_to  :channel
      t.belongs_to  :customer
      t.belongs_to  :customer_mc     
      t.string      :order_identifier
      t.decimal     :total_value, precision: 7, scale: 2
      t.decimal     :products_value, precision: 7, scale: 2
      t.decimal     :shipping_value, precision: 7, scale: 2
      t.decimal     :amount_paid, precision: 7, scale: 2
      t.date        :created_on
      t.datetime    :created_on_ts
      t.date        :paid_on
      t.datetime    :paid_on_ts      
      t.date        :shipping_on
      t.datetime    :shipping_on_ts
      t.date        :estimate_delivery_on
      t.datetime    :estimate_delivery_on_ts
      
      t.timestamps
    end
  end
end

class CreateCustomerMcs < ActiveRecord::Migration
  def change
    create_table :customer_mcs do |t|

      t.belongs_to  :channel
      t.belongs_to  :customer
      t.string      :name
      t.string      :mc_id      #es: username in ebay
      t.string      :email
      
      t.timestamps
    end
  end
end

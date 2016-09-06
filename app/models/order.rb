class Order < ActiveRecord::Base
  belongs_to :customer
  belongs_to :customer_mc
  has_many :order_rows
  
end

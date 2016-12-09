class CustomerMc < ActiveRecord::Base
  has_many :orders
  
  def count_orders
    ret = {}
    ret[:orders]      = count_oders       = self.orders.count
    ret[:orders_OPEN] = count_order_OPEN  = self.orders.apply_filter_OPEN.count
    ret
  end
  
  def count_other_orders(order_id)
    ret = {}
    ret[:orders]      = count_oders       = self.orders.where('id <> ?', order_id).count
    ret[:orders_OPEN] = count_order_OPEN  = self.orders.apply_filter_OPEN.count
    ret
  end

    
end

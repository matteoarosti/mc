class Order < ActiveRecord::Base
  belongs_to :customer
  belongs_to :customer_mc
  has_many :order_rows
  
  
  def self.apply_filter_OPEN
    return self.where(shipping_on: nil)
  end
  
  def self.apply_filter_DELIVERY_DATE_EXPIRED
    return self.apply_filter_OPEN.where(['estimate_delivery_on <= ?', DateTime.now])
  end
    
  
  def paid_on_year_week
    self.paid_on.strftime("%G-W%V")
  end
  
end

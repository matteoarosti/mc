class OrderRow < ActiveRecord::Base
  
  belongs_to :order
  belongs_to :product
  
  
  def product_name
    self.product.name
  end
  
  def paid_on_year_week
    self.order.paid_on.strftime("%G-W%V")
  end
  
  def year_week
    "#{self.year}-W#{self.week}"
  end
  
end

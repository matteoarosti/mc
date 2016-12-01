class ProductMc < ActiveRecord::Base
  
  belongs_to :product
  
  
  after_save :sincro_order_rows
  
  def sincro_order_rows
      logger.info 'ProductMc:after_save (sincro_order_rows)'
      OrderRow.where(product_mc_id: self.id).each do |r|
        r.product_id = self.product_id
        r.save
      end
  end
  
end

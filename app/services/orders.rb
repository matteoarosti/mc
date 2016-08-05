class Orders
	
 def getOrders()
 	puts "getOrders - START"
 	
 	#puts EbayClient.api.get_ebay_official_time!.to_yaml

	p = {number_of_days: 1, order_status: 'Completed'}
	
    orders =  EbayClient.api.get_orders! p
 	
 	orders[:order_array][:order].each do |o|
 	   	  
 	  puts "--------------------------------------------------------------------------------------"
 		puts [
 		     o[:order_id].to_s, 
 		     o[:buyer_user_id].to_s,
 		     o[:order_status].to_s,
 		     o[:total].to_s,
         o[:subtotal].to_s,
 		     o[:amount_paid].to_s,
 		     o[:created_time].to_s,
 		     o[:checkout_status][:status].to_s,
 		     o[:checkout_status][:e_bay_payment_status].to_s,
 		     o[:shipped_time].to_s
 		 ].join(' | ')
 		 
 		#creo/aggiorno ordine
 		 order_identifier = o[:order_id]
 		 n = Order.find_or_create_by(channel: 'EBAY', order_identifier: order_identifier)
 		   n.created_on  = n.created_on_ts = o[:created_time]
 		   n.total_value     = o[:total]
 		   n.products_value  = o[:subtotal]
 		   n.shipping_value   = o[:shipping_details][:shipping_service_options][:shipping_service_cost]
 		   n.amount_paid = o[:amount_paid]
 		   n.paid_on = n.paid_on_ts = o[:paid_time]
 		   n.shipping_on    = o[:shipped_time]
 		   n.shipping_on_ts = o[:shipped_time] 		     
 		 n.save!    
 		 
 		 
 		if o[:transaction_array][:transaction].kind_of?(Array)
 		  ts = o[:transaction_array][:transaction]
 		else
 		  ts = [o[:transaction_array][:transaction]]
 	  end
 	  
 	  ts.each do |t|
 	    puts [
 	      t[:buyer][:email].to_s,
 	      t[:transaction_id].to_s,  
 	      t[:item][:item_id].to_s,
 	      "( #{t[:quantity_purchased].to_s} )",
 	      t[:transaction_price].to_s, 
 	      t[:item][:title].to_s
 	     ].join(' | ')
 	  end #transactions.each

 		 
 	end  #orders.each
 	
 end	
	
end
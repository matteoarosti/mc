class SingleOrders
	
 def getOrder()
 	puts "getOrder - START"
 	
 	#puts EbayClient.api.get_ebay_official_time!.to_yaml
 	
 	channel = Channel.find(1)

#	p = {number_of_days: 13, order_status: 'Completed'}
 p = {order_i_d_array: [{order_i_d: '161986631422-1485174670006'}]}

    orders =  EbayClient.api.get_orders! p

    
#  File.open("out_order.log", "w+") do |f|
#    f.write(orders.to_xml)
#  end
#  return      

        
   	
     
     
     o = orders[:order_array][:order]
        	  
      #next if o.kind_of?(Array) 
       

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
   		 n = Order.find_or_initialize_by(channel_id: channel.id, order_identifier: order_identifier) do |o_on_create|
         o_on_create.created_on  = o_on_create.created_on_ts = o[:created_time]
         o_on_create.total_value     = o[:total]
         o_on_create.products_value  = o[:subtotal]
         o_on_create.shipping_value   = o[:shipping_details][:shipping_service_options][:shipping_service_cost]
           
         #ricerco cliente mc
         c_mc = CustomerMc.find_or_create_by(channel_id: channel.id, mc_id: o[:buyer_user_id].to_s)
         o_on_create.customer_mc_id = c_mc.id
         o_on_create.customer_id = c_mc.customer_id
                      
   		 end #on create order
   		 
   		 #aggiorno eventuali dati di pagamento/spedizione
   		 n.amount_paid = o[:amount_paid]
   		 n.paid_on = n.paid_on_ts = o[:paid_time]
   		 n.shipping_on    = o[:shipped_time]
   		 n.shipping_on_ts = o[:shipped_time]
   		   
   		 new_order = n.new_record?
   		      		     
   		 n.save!    
   		 
  
   		 if new_order
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
            
              #customer email  
              n.customer_mc.email = t[:buyer][:email] unless t[:buyer][:email].nil?
              n.customer_mc.save!
              
              #estimaed delivery
              n.estimate_delivery_on = n.estimate_delivery_on_ts = t[:shipping_service_selected][:shipping_package_info][:estimated_delivery_time_max]
              n.save!
            
             
             #costruisco l'arrey delle varianti
             ar_variations = []
             
             if t[:variation][:variation_specifics][:name_value_list].kind_of?(Array)
               ta = t[:variation][:variation_specifics][:name_value_list]
             else
               ta = [t[:variation][:variation_specifics][:name_value_list]]
             end  
               
             ta.each do |v|
               ar_variations << v[:value].to_s
             end
             
             ar_variations_string = "[" + ar_variations.join(',') + "]"
             
              
             if t[:item][:title].to_s.end_with?(ar_variations_string)
               puts 'Trovata occorrenza variation_sring in item title'
             else
               puts "**ERROR**: Non trovata occorenza variation_string in item title"
               return
             end
             
             
             #in base a item_id recupero da ProductMc il product di riferimento
             p_mc = ProductMc.find_or_create_by(channel_id: channel.id, mc_id: t[:item][:item_id].to_s) do |p_mc_on_create|
               puts "Creo nuovo ProductMc"
               name_size = t[:item][:title].to_s.size - ar_variations_string.size
               p_mc_on_create.name = t[:item][:title].to_s[0, name_size]         
             end  
      
      
               #in base a ar_variation_string recupero ProductVariationMc
               pv_mc = ProductVariationMc.find_or_create_by(channel_id: channel.id, product_mc_id: p_mc.id, variation_string: ar_variations_string) do |pv_mc_on_create|
                 puts "Creo nuovo ProductVariationMc"
                 pv_mc_on_create.name = t[:item][:title].to_s         
               end
                         
              n.order_rows.create(
                 mc_transaction: t[:transaction_id].to_s,
                 mc_item: t[:item][:item_id].to_s,
                 mc_title: t[:item][:title].to_s,
                 qty: t[:quantity_purchased].to_s,
                 price: t[:transaction_price].to_s,
                   
                 product_mc_id: p_mc.id,
                 product_id: p_mc.product_id,
                 product_variation_mc_id: pv_mc.id,
                 product_variation_id: pv_mc.product_variation_id              
              ) 
               
          end #transactions.each
       else #order old

         #recupero email che in origine non caricavo
          if o[:transaction_array][:transaction].kind_of?(Array)
            ts = o[:transaction_array][:transaction]
          else
            ts = [o[:transaction_array][:transaction]]
          end
          
          ts.each do |t|
            n.customer_mc.email = t[:buyer][:email] unless t[:buyer][:email].nil?
            n.customer_mc.save!
            
            #estimaed delivery
            begin #ToDo: segnalare errore
              n.estimate_delivery_on = n.estimate_delivery_on_ts = t[:shipping_service_selected][:shipping_package_info][:estimated_delivery_time_max]
              n.save!
            rescue
              puts "\nERRORE RECUPERO estimated_delivery_on date"
            end  
          end
            
       end #if new_order     	 	

 	
 end	
	
end
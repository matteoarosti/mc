class Insertions
	
 def getInsertions(per_page, page_number)
 	puts "getOrders - START"
 	
 	channel = Channel.find(1)
  
 	p = {pagination: {entries_per_page: per_page, page_number: page_number}, 
 	     end_time_from: (Time.now).at_beginning_of_day.utc.iso8601(3), 
 	     end_time_to:   (Time.now+120.days).at_beginning_of_day.utc.iso8601(3),
 	     detail_level: 'ReturnAll', granularity_level: 'Fine', include_watch_count: true
 	     }
  items =  EbayClient.api.get_seller_list! p
  
#       File.open("out_insertion.log", "w+") do |f|
#         f.write(items.to_xml)
#       end
#       return      
  
 
  items[:item_array][:item].each do |o| 
    
    #o = items[:item_array][:item]
    item_id       = o[:item_id]
    title         = o[:title]
    category_name = o[:primary_category][:category_name]
    category_ar   = category_name.split(':')
    qty_sold      = o[:selling_status][:quantity_sold]
      
    puts title
    
    n = ProductMc.find_or_initialize_by(mc_id: item_id, channel_id: channel.id)
    n.name = title
    n.num_solded  = qty_sold
    category_ar.each_with_index do |cn, kn|
      n.send("category_name_#{kn+1}=", cn)
    end
  
    n.save!
  end #each insertion
  
 end	
	
end
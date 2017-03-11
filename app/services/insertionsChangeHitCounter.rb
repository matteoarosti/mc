class InsertionsChangeHitCounter
	
 def setHitCounter()
 	puts "InsertionsChangeHitcounter - START"
 	
 	channel = Channel.find(1)
  
 	p = {'ItemID' => '162377386656',
 	      output_selector: 'hitCount'
 	     }
  items =  EbayClient.api.get_item! p
  puts items.to_xml
 end	
	
end
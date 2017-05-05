class ParseHtmlPage
	
 def call(n_day_before=10)
   puts "Start"
   require 'open-uri'

   n_for_page = 200
   
   for i in -n_day_before..-0
     for pagination in 0..4
        d = Date.today + i
        puts "------- #{d.to_s} - (pag: #{pagination})------------"            
         
         url = "http://localhost/login_ebay.php?date=#{d.strftime('%Y-%m-%d')}&offset=#{n_for_page * pagination}"
         fh = open(url, 
            "User-Agent" => "Code-Maven-Example (see: http://code-maven.com/download-a-page-using-ruby )"
         )
         html = fh.read
      
         str1_markerstring = '<tr id="gridRowId'
         str2_markerstring = '</tr>'
         
         str1_a = '<a'
         str2_a = '">'
         
         str1_p = '<p>'
         str2_p = '</p>'
         
         rows = html.split('<tr id="gridRowId')
         
         rows[1,1000].each do |r|
           tds = r.split('<td')
           seq = tds[1][/#{str1_p}(.*?)#{str1_a}/m, 1]
           
           begin
            #per le inserzioni non piu' attive non ho il link 
            item_id = tds[1][/#{str1_a}(.*?)#{str2_a}/m, 1].split('/').last
           rescue
            item_id = impressions = tds[1][/#{str1_p}(.*?)#{str2_p}/m, 1].split('.').last.strip
           end
             
           impressions = tds[2][/#{str1_p}(.*?)#{str2_p}/m, 1]
           visits = tds[4][/#{str1_p}(.*?)#{str2_p}/m, 1]
           transactions = tds[6][/#{str1_p}(.*?)#{str2_p}/m, 1]
        
           puts "->#{seq} - #{item_id}, impression: #{impressions}, visits: #{visits}, transactions: #{transactions}"
           
           productMc = ProductMc.find_or_create_by(mc_id: item_id)
           
           pmc_tl = ProductMcTl.find_or_create_by(tl_date: d, product_mc_id: productMc.id)
           pmc_tl.tl_num_impressions   = impressions
           pmc_tl.tl_num_visits        = visits
           pmc_tl.tl_num_transactions  = transactions
           pmc_tl.save!
      
         end     
          
     end #pagination
   end #for days
   
   
   

   

   
   
   
        #  File.open("out_parse_html_page.log", "w+") do |f|
        #    f.write(html)
        #  end
        #  return      
   
   
 end
 
 
end
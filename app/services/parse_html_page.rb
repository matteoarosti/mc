class ParseHtmlPage
	
 def call
   require 'open-uri'
   url = "http://localhost/login_ebay.php"
   fh = open(url, 
      "User-Agent" => "Code-Maven-Example (see: http://code-maven.com/download-a-page-using-ruby )"
   )
   html = fh.read
   
   #html_doc = Nokogiri::HTML(html)
   #tds =  html_doc.xpath("//table/tr/td22")

   str1_markerstring = '<tr id="gridRowId'
   str2_markerstring = '</tr>'

   
   str1_a = '<a'
   str2_a = '">'
   
   str1_p = '<p>'
   str2_p = '</p>'
   

   
   rows = html.split('<tr id="gridRowId')
   
   rows[1...-1].each do |r|
     tds = r.split('<td')
     item_id = tds[1][/#{str1_a}(.*?)#{str2_a}/m, 1].split('/').last
     impressions = tds[2][/#{str1_p}(.*?)#{str2_p}/m, 1]
     visits = tds[4][/#{str1_p}(.*?)#{str2_p}/m, 1]
     transactions = tds[6][/#{str1_p}(.*?)#{str2_p}/m, 1]
  
     puts "-> #{item_id}, impression: #{impressions}, visits: #{visits}, transactions: #{transactions}"

   end

   

   

   
   
   
        #  File.open("out_parse_html_page.log", "w+") do |f|
        #    f.write(html)
        #  end
        #  return      
   
   
 end
 
 
end
class TestTablePivot
	
 def call
   g = PivotTable::Grid.new do |g|
     g.source_data  = Order.all.limit(3)
     g.column_name  = :paid_on_year_week
     g.row_name     = :channel_id
     g.value_name   = :products_value
   end
   g.build
   puts g.to_yaml
 end
 
 
end
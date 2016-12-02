class ProductsController < ApplicationController
  
  def main_view
    #render json: {:success => true, :items => {:html => 'aaaaa'}}
  end

  
  def get_rows
    items = Product.all
    render json: {:success => true, :items => items.as_json()}
  end  
  
  
  def get_rows_mc
    items = ProductMc.all
    render json: {:success => true, :items => items.as_json()}
  end
  
  
  def product_new 
    item = Product.new
    form_from = params[:form_from] || {}
    item.name = form_from[:name]
    render partial: "product_form", locals: {item: item}
  end
  
  def product_edit
    render partial: "product_form", locals: {item: Product.find(params[:rec_id])}
  end
  
    
  def product_list
  end

  def exe_save
    if params[:data][:id].blank?
      item = Product.new
    else
      item = Product.find(params[:data][:id])
    end
    params[:data].permit!
    item.update(params[:data])
    item.save!()
    render json: {:success => true, :data=>[item.as_json()]}
  end
    
  
  
  # STATISTICHE #
  def product_stat_list
  end

  def get_stat_rows
    counts = Product.select('products.*, sum(order_rows.qty) as s_qty, count(distinct order_id) as c_orders').joins(order_rows: :order).group('products.id, products.name')
    
    if (params[:filter] == 'l7d')
      counts = counts.where('paid_on_ts >= ?', 7.days.ago)
    end
    if (params[:filter] == 'l1d')
      counts = counts.where('paid_on_ts >= ?', 1.days.ago)
    end
    
    
    render json: {:success => true, :items => counts.as_json()}
  end


      
  
  # PIVOT #
  def products_pivot
  end
  
  def products_pivot_data    
    items_db = OrderRow.select('products.id as product_id, products.name, year(paid_on) as year, week(paid_on) as week, sum(qty) as s_qty, count(*) as c_row').joins(:order, :product).group('products.id', 'products.name', 'year(paid_on)', 'week(paid_on)')
    items = items_db.group_by(&:product_id).map{ |product_id, weeks| 
          rw = {:product_id => product_id.to_i, :c_row => {}}
          weeks.each do |w|
            rw[:product_name] = w[:name]
            rw["#{w[:year]}-W#{w[:week]}"] = w[:s_qty]
            rw["c_row_#{w[:year]}-W#{w[:week]}"] = w[:c_row]              
          end
          rw
    }     
            
    render json: {:success => true, :items => items}
    
  end
  
  
  ############## products_mc ######################
  
  def product_mc_edit
    render partial: "product_mc_form", locals: {item: ProductMc.find(params[:rec_id])}
  end
  
  def product_mc_exe_save
    if params[:data][:id].blank?
      item = ProductMc.new
    else
      item = ProductMc.find(params[:data][:id])
    end
    params[:data].permit!
    item.update(params[:data])
    item.save!()
    render json: {:success => true, :data=>[item.as_json()]}
  end
  
  
end

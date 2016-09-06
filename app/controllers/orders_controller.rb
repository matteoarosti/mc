class OrdersController < ApplicationController

  def main_view
    #render json: {:success => true, :items => {:html => 'aaaaa'}}
  end

    
  def get_rows
    o = Order.find(1)
    items = Order.all
    render json: {:success => true, :items => items.as_json(:include => {
        customer_mc: {only: [:mc_id]},
        customer: {only: [:name]}
    })}
  end

  
 def order_detail
   @item = Order.find(params[:rec_id])     
 end
 
 def get_row_details
   items = OrderRow.where('order_id = ?', params[:rec_id]).as_json()
   render json: {:success => true, :items => items.as_json()}
 end   
  
end

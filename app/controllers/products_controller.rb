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
    render partial: "product_form", locals: {item: Product.new}
  end
    
  def product_list
  end
  
end

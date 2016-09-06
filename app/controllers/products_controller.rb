class ProductsController < ApplicationController
  
  def main_view
    #render json: {:success => true, :items => {:html => 'aaaaa'}}
  end

  
  def get_rows_mc
    items = ProductMc.all
    render json: {:success => true, :items => items.as_json()}
  end
  
  
end

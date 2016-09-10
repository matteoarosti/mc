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

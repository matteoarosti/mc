class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #### MATTEO   protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  
  require "#{Rails.root}/lib/extjs_sc_utility.rb"
  
  
  def get_combo_data
    ret = {}
    model_class = extjs_sc_model.to_s
    ret[:success] = true
    ret[:items] = model_class.constantize.order(model_class.constantize.combo_displayField()).limit(500)
    
    if !params[:filter_id].nil?
      ret[:items] = ret[:items].where(id: params[:filter_id])
    end  
      
    render json: ret
  end

  def extjs_sc_model
    controller_name.classify
  end  
  
  
  def search_std
  end

  def search_std_get_data
    ret = {}
    model_class = extjs_sc_model.to_s
    ret[:success] = true
    ret[:items] = model_class.constantize.order(model_class.constantize.combo_displayField()).limit(500)
      
    unless params[:search_std_form].nil?
      params[:search_std_form].each do |kp, p|
        ret[:items] = ret[:items].where("#{kp} LIKE ?", "%#{p}%") unless p.empty?
      end
    end
        
    render json: ret
  end
  
      
end

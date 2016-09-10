class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  require "#{Rails.root}/lib/extjs_sc_utility.rb"
  
  
  def get_combo_data
    ret = {}
    model_class = extjs_sc_model.to_s
    ret[:success] = true
    ret[:items] = model_class.constantize.order(model_class.constantize.combo_displayField()).limit(500)
    render json: ret
  end

  def extjs_sc_model
    controller_name.classify
  end  
  
    
end

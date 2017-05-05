class VjsController < ApplicationController

  def show_view
    render :partial => "#{params[:module]}/#{params[:path]}"
  end  
    
  def show_component
    render :partial => "#{params[:module]}/components/#{params[:path]}"
  end
  
end

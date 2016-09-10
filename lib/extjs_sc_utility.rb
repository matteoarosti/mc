  #PER EXTJS SCAFFOLD
  
 
 
 class ActiveRecord::Base
   
   def display_info_record
     created_user = User.find(self.created_user_id) rescue created_user = User.new 
     updated_user = User.find(self.updated_user_id) rescue updated_user = User.new
     
     ret = ''
     ret += "Created on #{self.created_at.strftime("%d/%m/%y %H:%M")} by #{created_user.name.to_s}"
     ret += "<br/>Last modified on #{self.updated_at.strftime("%d/%m/%y %H:%M")} by #{updated_user.name.to_s}"
     return ret
   end
 

  ###################################################################
  # EXTJS SCAFFOLD
  ###################################################################
  def self.combo_displayField
   'name'
  end
 

 #defaults
 def self.as_json_prop()
     return {}
 end

 
 def self.extjs_sc_list_add_default_join_on_my_filters(rel)
     return rel
 end  

 
end #ActiveRecord::Base
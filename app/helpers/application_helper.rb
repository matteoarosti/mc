module ApplicationHelper

 ##############################################################   
  def extjs_std_textfield(name, item, p = {}, attr = {})
 ##############################################################    
   input_name = p[:input_name] || p[:input_prefix].to_s + name
   add_attr = extsj_create_attr_str(attr)
   ret = "{xtype: 'textfield', fieldLabel: #{(p[:fieldLabel] || name.humanize).to_json}, name: #{input_name.to_json}, value: #{item.send(name).to_json}, maxLength: #{item.class.columns_hash[name].limit}, allowBlank: #{p[:allowBlank] || false} #{add_attr}}" 
  end
  
  
  ##############################################################  
  def extjs_std_combo_model(name, item, p = {}, attr = {})
  ##############################################################    
   field_name = name + '_id'
   input_name = p[:input_name] || (p[:input_prefix].to_s + name + '_id')    
   model_class = name.camelize.constantize
 
   add_attr = extsj_create_attr_str(attr)
   
   ret = "
     {
       xtype: 'combobox', name: #{input_name.to_json}, value: #{item.send(field_name).to_json},
       fieldLabel: #{(p[:fieldLabel] || name.humanize).to_json},
       displayField: #{model_class.combo_displayField.to_json},
       valueField: 'id',
       forceSelection: true,
       allowBlank: #{p[:allowBlank] || false},
       triggerAction: 'all',
       typeAhead: true,
       queryMode: 'local',
       lastQuery: '',  
       store: #{p[:store] || extjs_std_store_model(name)},
       listeners: {#{p[:listeners]}}
       #{add_attr}
     }
     "
   return ret 
  end
  
  

  ##############################################################  
  def extjs_std_combo_model_complete(name, item, p = {}, attr = {})
  ##############################################################    
   field_name = name + '_id'
   input_name = p[:input_name] || (p[:input_prefix].to_s + name + '_id')    
   model_class = name.camelize.constantize
 
   add_attr = extsj_create_attr_str(attr)
   
   ret_field = "
     {
       xtype: 'combobox', name: #{input_name.to_json}, value: #{item.send(field_name).to_json},
       fieldLabel: #{(p[:fieldLabel] || name.humanize).to_json},
       displayField: #{model_class.combo_displayField.to_json},
       valueField: 'id',
       flex: 1,
       forceSelection: true,
       allowBlank: #{p[:allowBlank] || false},
       triggerAction: 'all',
       typeAhead: true,
       queryMode: 'local',
       lastQuery: '',  
       store: #{p[:store] || extjs_std_store_model(name)},
       listeners: { //todo: merge con altri eventuali listeners
          onSearchSelected: function(rec_id, form_from){
              this.store.proxy.extraParams.filter_id = rec_id
              this.store.load();
              this.setValue(rec_id);
              form_from.close();
          }
       }
       #{add_attr}
     }
     "
   
   ret = "{
    xtype: 'fieldcontainer',
    layout: {type: 'hbox', align : 'stretch', pack  : 'start'}, 
    items: [
      #{ret_field},
      {
       xtype: 'button',
       text: 'Search',
       width: 100,
       handler: function(){
        acs_show_panel_std(this.up('tabpanel'), '#{root_path}#{name.pluralize}/search_std', {
          input_id_from: this.up('fieldcontainer').down('combobox').id,
        });
       }   
      }, {
        xtype: 'button',
        text: 'Create',
        width: 100,
        handler: function(){
         acs_show_panel_std(this.up('tabpanel'), '#{root_path}#{name.pluralize}/product_new', 
              {
                input_id_from: this.up('fieldcontainer').down('combobox').id,
                form_from: this.up('form').getValues()
              },
              {onSelectEvent2: function(){console.log('aaaaaaaaaaaaaa')}},
              {onSelectEvent: function(){console.log('aaaaaaaaaaaaaa')}}
           );
        }   
       }
    ]
   }
   "
   
   return ret 
  end
 
  
    
  
 ###############################################################
 # UTILITY
 ###############################################################  
  
  def extjs_std_store_model(model)
   ret = "Ext.create('Ext.data.Store', {
           fields: [],
           autoLoad: true,
           proxy: {
               type: 'ajax',
               url: '#{root_path}#{model.pluralize}/get_combo_data',              
               reader: {
                   type: 'json',
                   rootProperty: 'items'                  
               }       
           },          
       })"
   return ret    
  end 

  
  
  def extsj_create_attr_str(attrs)
   return '' if attrs.empty?
   rets = []
   attrs.each do |kattr, attr|
    rets<< "#{kattr}: #{attr.to_json}"
   end
   return ", " + rets.join(",")
  end

  
  
end

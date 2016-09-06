class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|

      t.string      :name
      t.belongs_to  :manufacturer
      t.string      :manufacturer_ref   #id univoco per fornitore (es: FR61082)
      
      t.timestamps
    end
  end
end

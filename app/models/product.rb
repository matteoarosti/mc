class Product < ActiveRecord::Base
  belongs_to :manufacturer
  has_many   :order_rows
  
  validates :manufacturer_ref, uniqueness: { scope: :manufacturer, message: "Il codice deve essere univoco per produttore" }
end

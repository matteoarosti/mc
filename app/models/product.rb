class Product < ActiveRecord::Base
  belongs_to :manufacturer
  has_many   :order_rows
end

class CustomerMc < ActiveRecord::Base
  has_many :orders
end

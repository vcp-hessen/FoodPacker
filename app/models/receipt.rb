class Receipt < ActiveRecord::Base
  
  has_many :ingredients
  
end

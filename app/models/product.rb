class Product < ActiveRecord::Base
  
  validates :name, :unit, presence: true
  validates :name, uniqueness: true
  
end

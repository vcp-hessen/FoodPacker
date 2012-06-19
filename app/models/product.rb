class Product < ActiveRecord::Base
  
  has_many :ingredients
  
  validates :name, :unit, presence: true
  validates :name, uniqueness: true
  
end

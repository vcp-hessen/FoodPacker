class Receipt < ActiveRecord::Base
  
  has_many :ingredients, dependent: :destroy
  
  accepts_nested_attributes_for :ingredients, :allow_destroy => true
  
  attr_accessible :name, :ingredients_attributes
end

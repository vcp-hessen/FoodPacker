class Product < ActiveRecord::Base
  
  has_many :ingredients
  
  validates :name, :unit, presence: true
  validates :name, uniqueness: true
  
  before_destroy :enshure_not_referenced_by_ingredients
  
  def enshure_not_referenced_by_ingredients
    if ingredients.empty?
      return true
    else
      errors.add(:base, "Product is still used in reciepes")
      return false
    end
  end
  
  def name_with_unit
    name + " (" + unit + ")"
  end
  
end

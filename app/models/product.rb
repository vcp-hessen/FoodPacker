class Product < ActiveRecord::Base
  
  has_many :ingredients
  has_many :group_box_contents
  
  validates :name, :unit, presence: true
  validates :name, uniqueness: true
  
  before_destroy :enshure_not_referenced_by_ingredients
  
  def enshure_not_referenced_by_ingredients
    if ingredients.empty?
      return true
    else
      errors.add(:base, I18n.t('products.messages.error_has_ingredients'))
      return false
    end
  end
  
  def name_with_unit
    name + " (" + unit + ")"
  end
  
end

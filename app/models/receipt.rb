class Receipt < ActiveRecord::Base
  
  has_many :ingredients, dependent: :destroy
  has_and_belongs_to_many :meals
  
  accepts_nested_attributes_for :ingredients, :allow_destroy => true
  
  attr_accessible :name, :ingredients_attributes, :meals
  
  before_destroy :enshure_not_referenced_by_meals
  
  def enshure_not_referenced_by_meals
    if meals.empty?
      return true
    else
      errors.add(:base, I18n.t("receipts.messages.error_has_meals"))
      return false
    end
  end
end

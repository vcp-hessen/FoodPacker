class Receipt < ActiveRecord::Base
  
  has_many :ingredients, dependent: :destroy
  has_many :meals, :finder_sql => Proc.new{%Q{SELECT * FROM meals WHERE (meals.receipt_id = #{id} or meals.alt_receipt_id = #{id})}}
  
  accepts_nested_attributes_for :ingredients, :allow_destroy => true
  
  attr_accessible :name, :ingredients_attributes, :meals
  
  before_destroy :enshure_not_referenced_by_meals
  
  def enshure_not_referenced_by_meals
    if meals.empty?
      return true
    else
      errors.add(:base, I18n.t("receipt.messages.error_has_meals"))
      return false
    end
  end
end

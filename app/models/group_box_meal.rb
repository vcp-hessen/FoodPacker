class GroupBoxMeal < ActiveRecord::Base
  
  has_many :contents, class_name: "GroupBoxContents"
  has_one :group, through: :group_box
  
  belongs_to :group_box
  belongs_to :meal

  after_initialize do |group_box_meal|
    
    raise "initialized group box meal without meal_id" if group_box_meal.meal_id == nil
    
  end

  def build_contents_from_ingredients_hunger_factor(ingredients,hunger_factor)
    ingredients.each do |ingredient|
      quantity = ingredient.quantity / 10 * participants_count * hunger_factor
      contents.build(name: ingredient.product.name,quantity:quantity,unit:ingredient.product.unit)
    end
    contents
  end

end

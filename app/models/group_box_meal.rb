class GroupBoxMeal < ActiveRecord::Base
  
  has_many :contents, class_name: "GroupBoxContent"
  has_one :group, through: :group_box
  
  belongs_to :group_box
  belongs_to :meal

  after_initialize do |group_box_meal|
    
    raise "initialized group box meal without meal_id" if group_box_meal.meal_id == nil
    
  end

  def build_contents_from_ingredients_hunger_factor(ingredients,hunger_factor)
    ingredients.each do |ingredient|
      quantity = ingredient.quantity / 10 * participants_count * hunger_factor
      quantity = 1.0 if quantity < 1.0
      round_rest = quantity - quantity.floor
      if round_rest > 0.3
        quantity = quantity.floor + 1
      else
        quantity = quantity.floor
      end
      contents.build(product: ingredient.product,quantity:quantity)
    end
    contents
  end

end

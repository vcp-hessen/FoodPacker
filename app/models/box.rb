class Box < ActiveRecord::Base

  has_and_belongs_to_many :meals
  has_many :group_boxes

  def build_calculated_box_for_group(group)
    group_box = group_boxes.build(group: group)
    meals.each do |meal|
      group_meal = meal.group_meals.find_by_group_id(group.id)
      next if group_meal == nil
      
      group_box_meal = group_box.group_box_meals.build(meal:meal)
      receipt = group_meal.receipt
      
      group_box_meal.participants_count = group_meal.meal_participants_count
      hunger_factor = group_meal.meal_hunger_factor
      
      group_box_meal.build_contents_from_ingredients_hunger_factor receipt.ingredients, hunger_factor
    end
    group_box
  end

end

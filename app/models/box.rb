class Box < ActiveRecord::Base

  has_and_belongs_to_many :meals
  has_many :group_boxes

  def build_calculated_box_for_group(group)
    group_box = group_boxes.build(group: group)
    meals.find_each(:include => :group_meals) do |meal|

      group_meal = meal.group_meals.find_by_group_id(group.id, :include => [{:receipt => {:ingredients => :product}}, :meal])
      next if group_meal == nil
      
      group_box_meal = group_box.group_box_meals.build(meal:meal)
      receipt = group_meal.receipt
      
      group_box_meal.participants_count = group_meal.meal_participants_count
      group_box_meal.receipt_name = receipt.name
      
      hunger_factor = group_meal.meal_hunger_factor
      
      group_box_meal.build_contents_from_ingredients_hunger_factor receipt.ingredients, hunger_factor
    end
    group_box
  end
  
  def build_calculated_boxes
    meals.find_each(:include => :group_meals) do |meal|
      meal.group_meals.find_each(:include => [{:receipt => {:ingredients => :product}}, :meal, :group]) do |group_meal|
      
        group_box = group_boxes.each do |group_box|
          break group_box if group_box.group == group_meal.group
        end
        group_box = nil if group_box.kind_of?(Array)

        group_box = group_boxes.build(group: group_meal.group) if group_box.nil?
        group_box_meal = group_box.group_box_meals.build(meal:meal)
        receipt = group_meal.receipt
      
        group_box_meal.participants_count = group_meal.meal_participants_count
        group_box_meal.receipt_name = receipt.name
      
        hunger_factor = group_meal.meal_hunger_factor
      
        group_box_meal.build_contents_from_ingredients_hunger_factor receipt.ingredients, hunger_factor
      end
    end
    group_boxes
  end
  
  def create_calculated_boxes
    transaction do
      group_boxes = build_calculated_boxes
      group_boxes.each do |group_box|
        group_box.save!
      end
    end
  end

end

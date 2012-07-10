class GroupBoxMeal < ActiveRecord::Base
  
  has_many :contents, class_name: "GroupBoxContent", dependent: :destroy
  has_one :group, through: :group_box
  has_one :box, through: :group_box
  
  belongs_to :group_box
  belongs_to :meal

  after_initialize do |group_box_meal|
    
    raise "initialized group box meal without meal_id" if group_box_meal.meal_id == nil
    
  end

  def build_contents_from_ingredients_hunger_factor(ingredients,hunger_factor)
    ingredients.each do |ingredient|
      quantity = ingredient.calculate_quantity(for_people:participants_count, hunger_factor:hunger_factor)
      contents.build(product: ingredient.product,quantity:quantity)
    end
    contents
  end

end

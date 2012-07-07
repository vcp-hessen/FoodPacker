class Group < ActiveRecord::Base
  
  has_many :group_meals, dependent: :destroy
  has_many :meals, through: :group_meals
  
  accepts_nested_attributes_for :group_meals
  
  validates :name, presence: true
  validates :name, uniqueness: true
  
  validates :participants_count, numericality: { :only_integer => true , :greater_than => 0}
  validates :hunger_factor, numericality: {greater_than_or_equal_to: 0.4, less_than_or_equal_to: 1.6}
  
  after_create do |group|
    Meal.all.each do |meal|
      group.group_meals.create(meal_id: meal.to_param,receipt_id:meal.receipts.first.to_param)
    end
  end
end

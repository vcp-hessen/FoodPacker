class GroupMeal < ActiveRecord::Base
  
  belongs_to :group
  belongs_to :meal
  belongs_to :receipt
  
  validates :group_id, presence: true
  validates :meal_id, presence: true
  validates :receipt_id, presence: true
  validates :hunger_factor, presence: true
  validates :participants_count_deviation, presence: true
  
  validates :participants_count_deviation, numericality: { :only_integer => true }
  validates :hunger_factor, numericality: {greater_than_or_equal_to: 0.4, less_than_or_equal_to: 1.6}
  
  after_initialize do |group_meal|
    group_meal.hunger_factor ||= 1.0
    group_meal.participants_count_deviation ||= 0
  end
  
end

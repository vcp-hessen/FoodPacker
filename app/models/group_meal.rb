class GroupMeal < ActiveRecord::Base
  
  belongs_to :group
  belongs_to :meal
  belongs_to :receipt
  
  validates :group_id, presence: true
  validates :meal_id, presence: true
  validates :receipt_id, presence: true
  validates :hunger_factor, presence: true
  validates :participants_count_deviation, presence: true

end

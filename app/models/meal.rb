class Meal < ActiveRecord::Base

  has_and_belongs_to_many :receipts
  has_many :group_meals, dependent: :destroy
  has_many :groups, through: :group_meals

end

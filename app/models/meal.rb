class Meal < ActiveRecord::Base

  has_and_belongs_to_many :receipts
  has_many :group_meals, dependent: :destroy
  has_many :groups, through: :group_meals

  validates :receipts, :presence => true

  after_create do |meal|
    Group.all.each do |group|
      meal.group_meals.create(group_id: group.to_param,receipt_id:meal.receipts.first.to_param)
    end
  end
end

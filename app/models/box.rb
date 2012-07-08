class Box < ActiveRecord::Base

  has_and_belongs_to_many :meals
  has_many :group_boxes

end

class GroupBox < ActiveRecord::Base

  has_many :group_box_meals

  belongs_to :group
  belongs_to :box

end

class GroupBoxContent < ActiveRecord::Base

  belongs_to :group_box_meal
  belongs_to :product

end

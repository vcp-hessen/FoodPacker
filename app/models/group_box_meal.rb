class GroupBoxMeal < ActiveRecord::Base
  
  has_many :contents, class_name: "GroupBoxContents"
  
  belongs_to :group_box

end

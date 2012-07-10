class GroupBox < ActiveRecord::Base

  has_many :group_box_meals, dependent: :destroy

  belongs_to :group
  belongs_to :box

  after_initialize do |group_box|
    
    raise "initialized group box without group_id" if group_box.group_id == nil
    raise "initialized group box without box_id" if group_box.box_id == nil
    
  end
  
end

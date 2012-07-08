require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  
  test "groups name must be set" do
    group = Group.new
    assert group.invalid?
    assert group.errors[:name].any?
  end
  
  test "groups name must be unique" do
    group = groups(:group)
    group2 = Group.new(name: group.name)
    assert group2.invalid?
    assert group2.errors[:name].any?
  end
  
  test "group participants_count must be an integer" do
    group = groups(:group)
    group.participants_count = "foo"
    
    assert group.invalid?
    assert group.errors[:participants_count].any?
  end
  
  test "participants_count must be greater 0" do
    group = groups(:group)
    group.participants_count = 0
    
    assert group.invalid?, "Accepted participants_count 0"
    assert group.errors[:participants_count].any?, "No error for participants_count 0"
    
    group.participants_count = -1
    
    assert group.invalid?, "Accepted participants_count -1"
    assert group.errors[:participants_count].any?, "No error for participants_count -1"
    
    group.participants_count = 1
    
    assert group.valid?, "Declined participants_count 1"
    assert group.errors[:participants_count].empty?, "Error for participants_count 1"
  end
  
  test "hunger_factor must be a number" do
    group = groups(:group)
    group.hunger_factor = "foo"
    
    assert group.invalid?
    assert group.errors[:hunger_factor].any?
  end
  
  test "hunger_factor must be between 0.4 and 1.6" do
    group = groups(:group)
    group.hunger_factor = 0.0
    
    assert group.invalid?
    assert group.errors[:hunger_factor].any?
    
    group.hunger_factor = -0.1
    
    assert group.invalid?
    assert group.errors[:hunger_factor].any?
    
    group.hunger_factor = 0.4
    
    assert group.valid?
    assert group.errors[:hunger_factor].empty?
    
    group.hunger_factor = 1.0
    
    assert group.valid?
    assert group.errors[:hunger_factor].empty?
    
    group.hunger_factor = 1.6
    
    assert group.valid?
    assert group.errors[:hunger_factor].empty?
    
    group.hunger_factor = 1.62
    
    assert group.invalid?
    assert group.errors[:hunger_factor].any?
  end
  
  test "should have associated meals" do
    group = groups(:group)
    
    assert group.meals.count == 2
  end
  
  test "should associate all existing meals after creation" do
    group = Group.new(name: "Testgroup", hunger_factor:1.0, participants_count:42)
    group.save!
    
    assert group.meals.count == Meal.count
  end
  
  test "should have group boxes" do
    group = groups(:hungry_group)
    
    assert group.group_boxes.count == 3
  end
  
end

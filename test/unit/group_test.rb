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
  
end

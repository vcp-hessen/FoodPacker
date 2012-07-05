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
  
end

require 'test_helper'

class GroupMealTest < ActiveSupport::TestCase

  test "attributes may not be empty" do
    product = GroupMeal.new
    
    assert product.invalid?
    assert product.errors[:meal_id].any?
    assert product.errors[:group_id].any?
    assert product.errors[:receipt_id].any?
    assert product.errors[:hunger_factor].any?
    assert product.errors[:participants_count_deviation].any?
  end

end

require 'test_helper'

class MealTest < ActiveSupport::TestCase
  
  test "breakfast should have cereal receipt" do
    breakfast = meals(:breakfast)
    
    assert breakfast.receipts.include?(receipts(:cereals))
  end
  
  test "lunch should have soup and pork receipts" do
    breakfast = meals(:lunch)
    
    assert breakfast.receipts.include?(receipts(:soup))
    assert breakfast.receipts.include?(receipts(:pork))
  end
  
  test "lunch should have a group" do
    lunch = meals(:lunch)
    
    assert lunch.groups.include?(groups(:group))
  end
end

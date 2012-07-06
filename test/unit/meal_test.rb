require 'test_helper'

class MealTest < ActiveSupport::TestCase
  
  test "breakfast should have cereal receipt" do
    breakfast = meals(:breakfast)
    
    assert breakfast.receipt == receipts(:cereals)
  end
  
  test "lunch should have soup and pork receipts" do
    breakfast = meals(:lunch)
    
    assert breakfast.receipt == receipts(:soup)
    assert breakfast.alt_receipt == receipts(:pork)
  end
  
end

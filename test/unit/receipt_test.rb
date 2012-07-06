require 'test_helper'

class ReceiptTest < ActiveSupport::TestCase

  test "cereals should belong to breakfast meal" do
    cereals = receipts(:cereals)
    
    assert cereals.meals.include?(meals(:breakfast))
  end
  
  test "soup should belong to lunch meal" do
    soup = receipts(:soup)
    
    assert soup.meals.include?(meals(:lunch))
  end
  
  test "pork should belong to lunch meal" do
    pork = receipts(:pork)
    
    assert pork.meals.include?(meals(:lunch))
  end
  
  test "prok should report 2 meals" do
    pork = receipts(:pork)
    
    assert pork.meals.count == 2
  end

end

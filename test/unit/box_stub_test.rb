require 'test_helper'

class BoxStubTest < ActiveSupport::TestCase
  
  test "should have meals" do
    box_stub = box_stubs(:thursday_evening)
    
    assert box_stub.meals.count == 2
  end

end

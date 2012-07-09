require 'test_helper'

class GroupBoxContentTest < ActiveSupport::TestCase
  
  test "should have a product" do
    group_box_content = group_box_contents(:one)
    
    assert_equal products(:meat), group_box_content.product
  end
  
end

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  
  test "product attributes may not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:name].any?
    assert product.errors[:unit].any?
  end
  
  test "product name must be unique" do
    product = Product.new(name:"Zucker",unit:"g")
    product2 = Product.new(name:"Zucker",unit:"kg")
    assert product2.invalid?
    assert product2.errors[:name].any?
  end
  
end

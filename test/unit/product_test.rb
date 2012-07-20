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
  
  test "product can not be deleted if referenced by ingredients" do
    zucker = products(:zucker)
    ingredient = Ingredient.create(quantity:50.0)
    zucker.ingredients << ingredient
    
    zucker.destroy
    assert ! zucker.destroyed?
    assert zucker.errors[:base].any?
  end
  
  test "product has name with unit" do
    zucker = products(:zucker)
    
    assert zucker.name_with_unit == "Zucker (g)"
  end
  
  test "should have a rounding amount" do
    zucker = products(:zucker)
    
    zucker.rounding_amount = 500
    
    assert zucker.valid?
  end
end

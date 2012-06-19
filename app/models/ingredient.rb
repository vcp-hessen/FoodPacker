class Ingredient < ActiveRecord::Base
  belongs_to :product
  belongs_to :receipt
end

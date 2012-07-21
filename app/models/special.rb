class Special < ActiveRecord::Base
  belongs_to :group
  belongs_to :box
  belongs_to :product
end

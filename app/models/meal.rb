class Meal < ActiveRecord::Base
  
  belongs_to :receipt, foreign_key: 'receipt_id', class_name: 'Receipt'
  belongs_to :alt_receipt, foreign_key: 'alt_receipt_id', class_name: 'Receipt'
  
end

class Group < ActiveRecord::Base
  
  validates :name, presence: true
  validates :name, uniqueness: true
  
  validates :participants_count, :numericality => { :only_integer => true , :greater_than => 0}
end

class Ingredient < ActiveRecord::Base
  belongs_to :product
  belongs_to :receipt
  
  def human_readable_quantity
    begin
      ActionController::Base.helpers.number_to_human(quantity, :units => "units.#{product.unit}", :precision => 3)
    rescue I18n::MissingTranslationData
      ActionController::Base.helpers.number_to_human(quantity, :units => {unit: product.unit}, :precision => 3)
    end
  end
  
  def calculate_quantity(options = {})
    raise "I need a count to calculate" if options[:for_people].nil?
    
    options.reverse_merge! vegetarians: options[:for_people], hunger_factor: 1.0
    
    result = quantity / 10 * options[:for_people] * options[:hunger_factor]
    result = 1.0 if result < 1.0
    round_rest = result - result.floor
    if round_rest > 0.3
      result = result.floor + 1
    else
      result = result.floor
    end
    
  end
  
end

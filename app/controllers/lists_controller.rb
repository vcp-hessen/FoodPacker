class ListsController < ApplicationController
  
  before_filter :login_required

  # GET /lists
  # GET /lists.json
  def index
    redirect_to :action => 'products_aggregate'
  end

  # GET /lists/products/aggregate
  # GET /lists/products/aggregate.json
  def products_aggregate
    quantities = GroupBoxContent.sum(:quantity,group: :product_id)
    quantities.delete_if {|key, value| value == 0 } 

    products = Product.find(quantities.keys)
    @products_quantities = {}
    products.each do |product|
      @products_quantities[product] = quantities[product.id]
    end

    respond_to do |format|
      format.html # products_aggregate.html.erb
      format.json { render json: @groups }
    end
  end
  
end

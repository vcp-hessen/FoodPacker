class ListsController < ApplicationController
  
  before_filter :login_required

  # GET /lists
  # GET /lists.json
  def index
    @boxes = Box.order(:start_time).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @boxes }
    end
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
  
  # GET /lists/products/overview
  # GET /lists/products/overview.json
  def products_overview

    @products_quantities = {}
    @boxes = Box.all

    @boxes.each do |box|
      quantities = GroupBoxContent.sum(:quantity,group: :product_id, conditions:{"group_boxes.box_id" => box.id},joins: :box)
      quantities.delete_if {|key, value| value == 0 }

      products = Product.all
      products.each do |product|
        @products_quantities[product] ||= {}
        @products_quantities[product][box] ||= quantities[product.id]
      end
    end

    respond_to do |format|
      format.html # products_overview.html.erb
      format.json { render json: @groups }
    end
  end

  # GET /lists/boxes/2/groups
  # GET /lists/boxes/2/groups.json
  def products_box
    contents = GroupBoxContent.find(:all,select:'group_box_contents.id,SUM(`quantity`) as quantity,product_id,MAX(group_box_contents.updated_at) as updated_at,group_boxes.group_id',include: [:product, :group], joins: {:group_box_meal => :group_box},conditions: {:group_boxes =>{box_id: params[:box_id]}}, group: [ :group_id, :product_id ])
    
    @last_updated_by_group = {}
    @contents_by_group = {}
    
    boxes = Box.all(order: :start_time)
    @box = nil
    @next_box = nil;
    boxes.each do |box|
      if ((@box != nil) && (@next_box == nil))
        @next_box = box
      end
      if box.id.to_s == params[:box_id].to_s
        @box = box
      end
    end
    
    contents.each do |content|
      group = Group.find(content.group_id)
      
      @contents_by_group[group] ||= []
      @contents_by_group[group] << content
      @last_updated_by_group[group] = content.updated_at if ((@last_updated_by_group[group] == nil) || (@last_updated_by_group[group] < content.updated_at))
    end
    
    @meals_by_group = {}

    @next_meals_by_group = {}

    @contents_by_group.keys.each do |group|
      group_box = GroupBox.find_by_group_id_and_box_id(group.id, params[:box_id])
      @meals_by_group[group] = group_box.group_box_meals
      if @next_box != nil
        group_box = GroupBox.find_by_group_id_and_box_id(group.id, @next_box.id)
        @next_meals_by_group[group] = group_box.group_box_meals
      end
    end

    respond_to do |format|
      format.html # products_box.html.erb
      format.json { render json: @contents_by_group }
    end
  end
  
  # GET /lists/boxes/2/groups/1
  # GET /lists/boxes/2/groups/1.json
  def products_box_group
    @group_box_contents = GroupBoxContent.find(:all,select:'group_box_contents.id,SUM(`quantity`) as quantity,MAX(group_box_contents.updated_at) as updated_at,product_id',include: :product, joins: {:group_box_meal => :group_box},conditions: {:group_boxes =>{box_id: params[:box_id],group_id: params[:group_id]}}, group: :product_id )
    @group = Group.find(params[:group_id])
    
    boxes = Box.all(order: :start_time)
    @box = nil
    @next_box = nil;
    boxes.each do |box|
      if @box != nil && @next_box == nil
        @next_box = box
      end
      if box.id.to_s == params[:box_id].to_s

        @box = box
      end
    end
    
    group_box = GroupBox.find_by_group_id_and_box_id(@group.id, @box.id)
    @meals = group_box.group_box_meals
    @next_meals = nil
    if @next_box != nil
      group_box = GroupBox.find_by_group_id_and_box_id(@group.id, @next_box.id)
      @next_meals = group_box.group_box_meals
    end

    @last_updated = nil
    @group_box_contents.each do |content|
      @last_updated = content.updated_at if ((@last_updated == nil) || (@last_updated < content.updated_at))
    end
    
    respond_to do |format|
      format.html # products_box_group.html.erb
      format.json { render json: @group_box_contents }
    end
  end
  
  # GET /lists/boxes/2/products
  # GET /lists/boxes/2/products.json
  def groups_box
    contents = GroupBoxContent.find(:all,select:'group_box_contents.id,SUM(`quantity`) as quantity,MAX(group_box_contents.updated_at) as updated_at,product_id,group_boxes.group_id',include: [:product, :group_box_meal, :group], joins: {:group_box_meal => :group_box},conditions: {:group_boxes =>{box_id: params[:box_id]}}, group: [ :product_id, :group_id ])
    
    @contents_by_product = {}
    contents.each do |content|
      @contents_by_product[content.product] ||= []
      @contents_by_product[content.product] << content
    end
    
    @last_updated_by_product = {}
    @contents_sum = {}
    @contents_by_product.each do |product,contents|
      sum = 0.0
      contents.each do |content| 
        sum += content.quantity
        @last_updated_by_product[product] = content.updated_at if ((@last_updated_by_product[product] == nil) || (@last_updated_by_product[product] < content.updated_at))
      end
      begin
        @contents_sum[product] = ActionController::Base.helpers.number_to_human(sum, :units => "units.#{product.unit}", :precision => 3)
      rescue I18n::MissingTranslationData
        @contents_sum[product] = ActionController::Base.helpers.number_to_human(sum, :units => {unit: product.unit}, :precision => 3)
      end
    end
    
    respond_to do |format|
      format.html # groups_box.html.erb
      format.json { render json: @contents_by_product }
    end
  end
  
  # GET /lists/boxes/2/products/3
  # GET /lists/boxes/2/products/3.json
  def groups_box_product
    @contents = GroupBoxContent.find(:all,select:'group_box_contents.id,SUM(`quantity`) as quantity,MAX(group_box_contents.updated_at) as updated_at,product_id,group_boxes.group_id',include: [:product, :group_box_meal, :group], joins: {:group_box_meal => :group_box},conditions: {:group_boxes =>{box_id: params[:box_id]},:product_id => params[:product_id]}, group: :group_id )
    @product = Product.find(params[:product_id])
    
    @last_updated = nil
    @sum = 0.0
    @contents.each do |content|
      @last_updated = content.updated_at if ((@last_updated == nil) || (@last_updated < content.updated_at))
      @sum += content.quantity
    end
    
    begin
      @sum = ActionController::Base.helpers.number_to_human(@sum, :units => "units.#{@product.unit}", :precision => 3)
    rescue I18n::MissingTranslationData
      @sum = ActionController::Base.helpers.number_to_human(@sum, :units => {unit: @product.unit}, :precision => 3)
    end
    
    respond_to do |format|
      format.html # groups_box_product.html.erb
      format.json { render json: @contents_by_product }
    end
  end
  
end

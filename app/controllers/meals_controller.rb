class MealsController < ApplicationController

  before_filter :login_required

  # GET /meals
  # GET /meals.json
  def index
    @meals = Meal.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meals }
    end
  end

  # GET /meals/1
  # GET /meals/1.json
  def show
    @meal = Meal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meal }
    end
  end

  # GET /meals/new
  # GET /meals/new.json
  def new
    @meal = Meal.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @meal }
    end
  end

  # GET /meals/1/edit
  def edit
    @meal = Meal.find(params[:id])
  end

  # POST /meals
  # POST /meals.json
  def create
    @meal = Meal.new(params[:meal])

    respond_to do |format|
      if @meal.save
        format.html { redirect_to @meal, notice: t('messages.model.created', model: t('meals.singular')) }
        format.json { render json: @meal, status: :created, location: @meal }
      else
        format.html { 
          flash.now[:error] = t('errors.template.header', model: t('meals.singular'), count: @group.errors.count)
          render action: "new"
          }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /meals/1
  # PUT /meals/1.json
  def update
    @meal = Meal.find(params[:id])

    respond_to do |format|
      if @meal.update_attributes(params[:meal])
        format.html { redirect_to @meal, notice: t('messages.model.updated', model: t('meals.singular')) }
        format.json { head :ok }
      else
        format.html { 
          flash.now[:error] = t('errors.template.header', model: t('meals.singular'), count: @product.errors.count)
          render action: "edit"
          }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meals/1
  # DELETE /meals/1.json
  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy

    respond_to do |format|
      if @meal.destroyed?
        format.html { redirect_to meals_url, notice: t('messages.model.destroyed', model: t('meals.singular'), name: @meal.name) }
        format.json { head :ok }
      else
        format.html {
          begin
            redirect_to :back, flash: {error: t('messages.model.cant_delete', model: t('meals.singular')), warning: @meal.errors[:base].to_sentence }
          rescue ActionController::RedirectBackError
            redirect_to meals_url, flash: {error: t('messages.model.cant_delete', model: t('meals.singular')), warning: @meal.errors[:base].to_sentence }
          end
        }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end
end

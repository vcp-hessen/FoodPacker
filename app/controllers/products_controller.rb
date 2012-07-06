class ProductsController < ApplicationController

  before_filter :login_required

  # GET /products
  # GET /products.json
  def index
    @products = Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: t('messages.model.created', model: t('products.singular')) }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { 
          flash.now[:error] = t('errors.template.header', model: t('products.singular'), count: @product.errors.count)
          render action: "new"
          }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: t('messages.model.updated', model: t('products.singular')) }
        format.json { head :ok }
      else
        format.html { 
          flash.now[:error] = t('errors.template.header', model: t('products.singular'), count: @product.errors.count)
          render action: "edit"
          }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      if @product.destroyed?
        format.html { redirect_to products_url, notice: t('messages.model.destroyed', model: t('products.singular'), name: @product.name) }
        format.json { head :ok }
      else
        format.html {
          begin
            redirect_to :back, flash: {error: t('messages.model.cant_delete', model: t('products.singular')), warning: @product.errors[:base].to_sentence }
          rescue ActionController::RedirectBackError
            redirect_to products_url, flash: {error: t('messages.model.cant_delete', model: t('products.singular')), warning: @product.errors[:base].to_sentence }
          end
        }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
end

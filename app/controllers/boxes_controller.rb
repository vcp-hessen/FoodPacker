class BoxesController < ApplicationController
  # GET /boxes
  # GET /boxes.json
  def index
    @boxes = Box.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @boxes }
    end
  end

  # GET /boxes/1
  # GET /boxes/1.json
  def show
    @box = Box.find(params[:id])
    @groups = Group.all
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @box }
    end
  end

  # GET /boxes/new
  # GET /boxes/new.json
  def new
    @box = Box.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @box }
    end
  end

  # GET /boxes/1/edit
  def edit
    @box = Box.find(params[:id])
  end

  # POST /boxes
  # POST /boxes.json
  def create
    @box = Box.new(params[:box])

    respond_to do |format|
      if @box.save
        format.html { redirect_to @box, notice: t('messages.model.created', model: t('boxes.singular')) }
        format.json { render json: @box, status: :created, location: @box }
      else
        format.html { 
          flash.now[:error] = t('errors.template.header', model: t('boxes.singular'), count: @box.errors.count)
          render action: "new"
          }
        format.json { render json: @box.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /boxes/1
  # PUT /boxes/1.json
  def update
    @box = Box.find(params[:id])

    respond_to do |format|
      if @box.update_attributes(params[:box])
        format.html { redirect_to @box, notice: t('messages.model.updated', model: t('boxes.singular')) }
        format.json { head :ok }
      else
        format.html { 
          flash.now[:error] = t('errors.template.header', model: t('boxes.singular'), count: @group.errors.count)
          render action: "edit"
          }
        format.json { render json: @box.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boxes/1
  # DELETE /boxes/1.json
  def destroy
    @box = Box.find(params[:id])
    @box.destroy

    respond_to do |format|
      if @box.destroyed?
        format.html { redirect_to boxes_url, notice: t('messages.model.destroyed', model: t('boxes.singular'), name: @box.name) }
        format.json { head :ok }
      else
        format.html {
          begin
            redirect_to :back, flash: {error: t('messages.model.cant_delete', model: t('boxes.singular')), warning: @box.errors[:base].to_sentence }
          rescue ActionController::RedirectBackError
            redirect_to boxes_url, flash: {error: t('messages.model.cant_delete', model: t('boxes.singular')), warning: @box.errors[:base].to_sentence }
          end
        }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # GET /boxes/1/groups
  # GET /boxes/1/groups.json
  def list_groups_for_box
    @box = Box.find(params[:id])
    @groups = Group.all

    respond_to do |format|
      format.html { render :list_groups }
      format.json { render json: @groups }
    end
  end
  
  # GET /boxes/1/group/2
  # GET /boxes/1/group/2.json
  def calculate_box_for_group
    @box = Box.find(params[:id])
    @group = Group.find(params[:group_id])
    
    @group_box = @box.build_calculated_box_for_group(@group)

    respond_to do |format|
      format.html { render :show_group_box }
      format.json { render json: @group_box }
    end
  end
end

class RecieptsController < ApplicationController
  # GET /reciepts
  # GET /reciepts.json
  def index
    @reciepts = Reciept.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reciepts }
    end
  end

  # GET /reciepts/1
  # GET /reciepts/1.json
  def show
    @reciept = Reciept.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reciept }
    end
  end

  # GET /reciepts/new
  # GET /reciepts/new.json
  def new
    @reciept = Reciept.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reciept }
    end
  end

  # GET /reciepts/1/edit
  def edit
    @reciept = Reciept.find(params[:id])
  end

  # POST /reciepts
  # POST /reciepts.json
  def create
    @reciept = Reciept.new(params[:reciept])

    respond_to do |format|
      if @reciept.save
        format.html { redirect_to @reciept, notice: 'Reciept was successfully created.' }
        format.json { render json: @reciept, status: :created, location: @reciept }
      else
        format.html { render action: "new" }
        format.json { render json: @reciept.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reciepts/1
  # PUT /reciepts/1.json
  def update
    @reciept = Reciept.find(params[:id])

    respond_to do |format|
      if @reciept.update_attributes(params[:reciept])
        format.html { redirect_to @reciept, notice: 'Reciept was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @reciept.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reciepts/1
  # DELETE /reciepts/1.json
  def destroy
    @reciept = Reciept.find(params[:id])
    @reciept.destroy

    respond_to do |format|
      format.html { redirect_to reciepts_url }
      format.json { head :ok }
    end
  end
end

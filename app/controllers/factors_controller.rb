class FactorsController < ApplicationController

  before_filter :get_factor, except: [ :new, :create ]

  # GET /factors/new
  # GET /factors/new.json
  def new
    @factor = Factor.new
    @factor.decision_id = @decision.id
    return if ! can_access Decision.find @factor.decision_id
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @factor }
    end
  end

  # GET /factors/1/edit
  def edit
    @factor = Factor.find(params[:id])
  end

  # POST /factors
  # POST /factors.json
  def create
    @factor = Factor.new(params[:factor])
    return if ! can_access @factor
    respond_to do |format|
      if @factor.save
        format.html { redirect_to edit_decision_path @factor.decision,
                                  notice: 'Factor was successfully created.' }
        format.json { render json: @factor, status: :created, location: @factor }
      else
        format.html { render action: "new" }
        format.json { render json: @factor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /factors/1
  # PUT /factors/1.json
  def update
    respond_to do |format|
      if @factor.update_attributes(params[:factor])
        format.html { redirect_to edit_decision_path @factor.decision,
                                  notice: 'Factor was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @factor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /factors/1
  # DELETE /factors/1.json
  def destroy
    @factor.destroy

    respond_to do |format|
      format.html { redirect_to edit_decision_path @factor.decision }
      format.json { head :ok }
    end
  end

  ##############################
  ##                          ##
  ##  PRIVATE METHODS BELOW!  ##
  ##                          ##
  ##############################

  private

  def get_factor
    @factor = Factor.find params[:id]
    @factor = nil if ! can_access @factor
  end

end

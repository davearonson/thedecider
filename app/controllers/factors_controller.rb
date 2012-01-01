class FactorsController < ApplicationController

  before_filter :get_factor, except: [ :new, :create ]

  # GET /factors/new
  # GET /factors/new.json
  def new
    @title = 'New Factor'
    @factor = Factor.new
    @decision_id = params[:decision_id]
    return if ! can_access Decision.find @decision_id
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @factor }
    end
  end

  # POST /factors
  # POST /factors.json
  def create
    @title = 'New Factor'
    @factor = Factor.new(params[:factor])
    @decision_id = params[:factor][:decision_id]
    return if ! can_access Decision.find(@decision_id)
    respond_to do |format|
      if @factor && can_access(@factor) && @factor.save
        format.html { redirect_to @factor.decision,
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
    @title = 'Edit Factor'
    @decision_id = params[:factor][:decision_id]
    respond_to do |format|
      if @factor.update_attributes(params[:factor])
        format.html { redirect_to @factor.decision,
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
    @title = 'Delete Factor'
    @factor.destroy

    respond_to do |format|
      format.html { redirect_to @factor.decision,
                    notice: 'Factor was successfully removed.' }
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

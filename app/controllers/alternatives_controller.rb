class AlternativesController < ApplicationController

  before_filter :get_alternative, except: [ :new, :create ]

  # GET /alternatives/new
  # GET /alternatives/new.json
  def new
    @alternative = Alternative.new
    @alternative.decision_id = params[:decision_id]
    return if ! can_access Decision.find @alternative.decision_id
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @alternative }
    end
  end

  # POST /alternatives
  # POST /alternatives.json
  def create
    @alternative = Alternative.new(params[:alternative])
    respond_to do |format|
      if @alternative && can_access(@alternative) && @alternative.save
        format.html { redirect_to @alternative.decision,
                                  notice: 'Alternative was successfully created.' }
        format.json { render json: @alternative, status: :created, location: @alternative }
      else
        format.html { render action: "new" }
        format.json { render json: @alternative.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /alternatives/1
  # PUT /alternatives/1.json
  def update
    respond_to do |format|
      if @alternative.update_attributes(params[:alternative])
        format.html { redirect_to @alternative.decision,
                                  notice: 'Alternative was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @alternative.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alternatives/1
  # DELETE /alternatives/1.json
  def destroy
    @alternative.destroy

    respond_to do |format|
      format.html { redirect_to @alternative.decision,
                    notice: "Alternative was successfully removed." }
      format.json { head :ok }
    end
  end


  ##############################
  ##                          ##
  ##  PRIVATE METHODS BELOW!  ##
  ##                          ##
  ##############################

  private

  def get_alternative
    @alternative = Alternative.find params[:id]
    @alternative = nil if ! can_access @alternative
  end

end

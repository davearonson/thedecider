class FactorsController < ApplicationController

  # TODO: make these not needed, by putting form for new one on page!

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
        format.html { redirect_to edit_decision_path(@decision_id),
                                  notice: 'Factor was successfully created.' }
        format.json { render json: @factor, status: :created, location: @factor }
      else
        format.html { render action: "new" }
        format.json { render json: @factor.errors, status: :unprocessable_entity }
      end
    end
  end

end

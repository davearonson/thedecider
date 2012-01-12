class AlternativesController < ApplicationController

  # TODO: make these not needed, by putting form for new one on page!

  # GET /alternatives/new
  # GET /alternatives/new.json
  def new
    @title = 'New Alternative'
    @alternative = Alternative.new
    @decision_id = params[:decision_id]
    return if ! can_access Decision.find @decision_id
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @alternative }
    end
  end

  # POST /alternatives
  # POST /alternatives.json
  def create
    @title = 'New Alternative'
    @alternative = Alternative.new(params[:alternative])
    @decision_id = params[:alternative][:decision_id]
    return if ! can_access Decision.find(@decision_id)
    respond_to do |format|
      if @alternative && can_access(@alternative) && @alternative.save
        format.html { redirect_to edit_decision_path(@decision_id),
                                  notice: 'Alternative was successfully created.' }
        format.json { render json: @alternative, status: :created, location: @alternative }
      else
        format.html { render action: "new" }
        format.json { render json: @alternative.errors, status: :unprocessable_entity }
      end
    end
  end

end

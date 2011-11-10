class DecisionsController < ApplicationController
  before_filter :get_user
  before_filter :get_decision, except: [ :index, :new, :create ]

  # GET /decisions
  # GET /decisions.json
  def index
    @show_all = @user.is_admin?
    @decisions = @show_all ? Decision.all : current_user.decisions
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @decisions }
    end
  end

  # GET /decisions/1
  # GET /decisions/1.json
  def show
    return if ! get_decision
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @decision }
    end
  end

  # GET /decisions/new
  # GET /decisions/new.json
  def new
    @decision = Decision.new
    @decision.user_id = current_user.id
    @alternative = Alternative.new
    @factor = Factor.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @decision }
    end
  end

  # GET /decisions/1/edit
  def edit
    get_decision
    @alternative = Alternative.new
    @factor = Factor.new
  end

  # POST /decisions
  # POST /decisions.json
  def create
    @decision = Decision.new(params[:decision])
    respond_to do |format|
      if @decision.save
        format.html { redirect_to edit_decision_path @decision, notice: 'Decision was successfully created.' }
        format.json { render json: @decision, status: :created, location: @decision }
      else
        format.html { render action: "new" }
        format.json { render json: @decision.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /decisions/1
  # PUT /decisions/1.json
  def update
    get_decision
    respond_to do |format|
      if @decision.update_attributes(params[:decision])
        format.html { redirect_to edit_decision_path @decision, notice: 'Decision was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @decision.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /decisions/1
  # DELETE /decisions/1.json
  def destroy
    get_decision
    @decision.destroy
    respond_to do |format|
      format.html { redirect_to decisions_path }
      format.json { head :ok }
    end
  end


  ##############################
  ##                          ##
  ##  PRIVATE METHODS BELOW!  ##
  ##                          ##
  ##############################


  private

  def get_decision
    @decision = Decision.find params[:id]
    @decision = nil if ! can_access @decision
  end

end

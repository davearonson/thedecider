class DecisionsController < ApplicationController

  before_filter :check_if_admin

  # GET /decisions
  # GET /decisions.json
  def index
    @decisions = @show_all ? Decision.all : @user.decisions
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @decisions }
    end
  end

  # GET /decisions/1
  # GET /decisions/1.json
  def show
    get_decision
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @decision }
    end
  end

  # GET /decisions/new
  # GET /decisions/new.json
  def new
    @decision = Decision.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @decision }
    end
  end

  # GET /decisions/1/edit
  def edit
    get_decision
  end

  # POST /decisions
  # POST /decisions.json
  def create
    @decision = Decision.new(params[:decision])
    # @decision.user_id ||= @user.id
    respond_to do |format|
      if @decision.save
        format.html { redirect_to [@user, @decision], notice: 'Decision was successfully created.' }
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
        format.html { redirect_to user_decision_path(@user, @decision), notice: 'Decision was successfully updated.' }
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
      format.html { redirect_to user_decisions_url(@user) }
      format.json { head :ok }
    end
  end


  ##############################
  ##                          ##
  ##  PRIVATE METHODS BELOW!  ##
  ##                          ##
  ##############################

  private


  def check_if_admin
    @user = current_user
    @show_all = @user.is_admin?
    user_id = params[:user_id]
    if user_id && user_id.to_i != @user.id && ! @user.is_admin?
      respond_to do |format|
        format.html { redirect_to root_path, notice: "No peeking at other people's stuff!" }
      end
    end
  end

  def get_decision
    id = params[:id]
    if id
      @decision = Decision.find(id)
      if ! @decision || (@decision.user_id != current_user.id && ! current_user.is_admin)
        respond_to do |format|
          format.html { redirect_to root_path, notice: 'That is not one of your decisions!' }
        end
      end
    end
  end

end

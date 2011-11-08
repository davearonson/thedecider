class AlternativesController < ApplicationController

  before_filter :check_if_admin
  before_filter :get_decision

  # GET /alternatives
  # GET /alternatives.json
  def index
    @alternatives = @decision.alternatives
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alternatives }
    end
  end

  # GET /alternatives/1
  # GET /alternatives/1.json
  def show
    get_alternative
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @alternative }
    end
  end

  # GET /alternatives/new
  # GET /alternatives/new.json
  def new
    @alternative = Alternative.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @alternative }
    end
  end

  # GET /alternatives/1/edit
  def edit
    get_alternative
  end

  # POST /alternatives
  # POST /alternatives.json
  def create
    @alternative = Alternative.new(params[:alternative])
    puts "\n\n\n#{@alternative.inspect}\n\n\n"
    # @alternative.decision_id ||= @decision.id

    respond_to do |format|
      if @alternative.save
        format.html { redirect_to edit_user_decision_path(@user, @decision),
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
    get_alternative
    respond_to do |format|
      if @alternative.update_attributes(params[:alternative])
        format.html { redirect_to @alternative, notice: 'Alternative was successfully updated.' }
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
    get_alternative
    @alternative.destroy if @alternative

    respond_to do |format|
      format.html { redirect_to edit_user_decision_path(@user, @decision) }
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
    @decision = Decision.find params[:decision_id]
  end

  def get_decision
    id = params[:decision_id]
    if id
      @decision = Decision.find(id)
      if ! @decision || (@decision.user_id != current_user.id && ! current_user.is_admin)
        format.html { redirect_to root_path, notice: 'That is not one of your decisions!' }
      end
    end
  end

  def get_alternative
    id = params[:id]
    @alternative = Alternative.find(id) if id
  end

end

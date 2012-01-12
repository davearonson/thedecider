class DecisionsController < ApplicationController

  before_filter :get_decision, except: [ :index, :new, :create ]

  # GET /decisions
  # GET /decisions.json
  def index
    @show_all = @user.is_admin?
    @decisions = @show_all ? Decision.all : current_user.decisions
    @title = "#{@user.is_admin? ? 'Everybody' : @user.username}'s Decisions"
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @decisions }
    end
  end

  def show
    respond_to do |format|
      format.html { render action: :edit }
      format.json { render json: @decision }
    end
  end

  # GET /decisions/new
  # GET /decisions/new.json
  def new
    @title = 'New Decision'
    @decision = Decision.new
    @show_all = @user.is_admin?
    puts "NEW decision User = #{@decision.user.inspect}"
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @decision }
    end
  end

  # GET /decisions/1/edit
  def edit
    puts "EDITING  decision User = #{@decision.user.inspect}"
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @decision }
    end
  end

  # POST /decisions
  # POST /decisions.json
  def create
    @title = 'New Decision'
    @decision = Decision.new(params[:decision])
    @decision.user_id = current_user.id
    @show_all = @user.is_admin?
    puts "CREATING decision User = #{@decision.user.inspect}"
    respond_to do |format|
      if @decision.save
        puts "\n\n\nSAVED #{@decision.inspect}\n\n\n"
        format.html { redirect_to edit_decision_path(@decision),
                      notice: 'Decision was successfully created.' }
        format.json { render json: @decision, status: :created, location: @decision }
      else
        puts "\n\n\nERRORED #{@decision.inspect}\n\n\n"
        format.html { render action: "new" }
        format.json { render json: @decision.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  # PUT /decisions/1
  # PUT /decisions/1.json
  def update
    respond_to do |format|
      if @decision.update_attributes(params[:decision])
        format.html { redirect_to edit_decision_path(@decision),
                      notice: 'Decision was successfully updated.' }
        format.json { head :ok }
      else
        @title = 'Edit Decision'
        format.html { render action: :edit }
        format.json { render json: @decision.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /decisions/1
  # DELETE /decisions/1.json
  def destroy
    @decision.destroy
    respond_to do |format|
      format.html { redirect_to decisions_path,
                    notice: 'Decision was successfully destroyed.' }
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
    @decision = Decision.find params[:id], include: [ :alternatives, :factors, :rankings ]
    @decision = nil if ! can_access @decision
  end

end

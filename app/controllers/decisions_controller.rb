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
    @decision = Decision.find(params[:id])

    if @decision && (@decision.user_id == @user.id || @show_all)
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @decision }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path,
                      notice: 'That is not one of your decisions!' }
      end
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
    @decision = Decision.find(params[:id])

    if ! @decision || (@decision.user_id != @user.id && ! @show_all)
      respond_to do |format|
        format.html { redirect_to root_path,
                      notice: 'That is not one of your decisions!' }
      end
    end
  end

  # POST /decisions
  # POST /decisions.json
  def create
    @decision = Decision.new(params[:decision])
    @decision.user_id ||= @user.id

    if ! @decision || (@decision.user_id != @user.id && ! @show_all)
      format.html { redirect_to root_path, notice: 'That is not one of your decisions!' }
    else
      respond_to do |format|
        if @decision.save
          puts "\n\n\nsaved #{@decision.inspect}\n\n\n"
          format.html { redirect_to [@user, @decision], notice: 'Decision was successfully created.' }
          format.json { render json: @decision, status: :created, location: @decision }
        else
          puts "\n\n\ncouldn't save #{@decision.inspect}\n\n\n"
          format.html { render action: "new" }
          format.json { render json: @decision.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /decisions/1
  # PUT /decisions/1.json
  def update
    @decision = Decision.find(params[:id])

    if ! @decision || (@decision.user_id != @user.id && ! @show_all)
      format.html { redirect_to root_path, notice: 'That is not one of your decisions!' }
    else
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
  end

  # DELETE /decisions/1
  # DELETE /decisions/1.json
  def destroy
    @decision = Decision.find(params[:id])
    @decision.destroy

    if ! @decision || (@decision.user_id != @user.id && ! @show_all)
      format.html { redirect_to root_path, notice: 'That is not one of your decisions!' }
    else
      respond_to do |format|
        format.html { redirect_to user_decisions_url(@user) }
        format.json { head :ok }
      end
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
  end

end

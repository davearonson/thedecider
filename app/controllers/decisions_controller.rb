class DecisionsController < ApplicationController

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
    max = 0
    tmp_ranks = Ranking.where(factor_id: @decision.factors.map(&:id)).
                        where(alternative_id: @decision.alternatives.map(&:id))
    @rankings = {}
    @colors = {}
    points = Hash.new 0
    @weightNames = {}
    @decision.factors.each do |fac|
      @weightNames[fac.id] = Level::weightNames[fac.weight_id-1]
      max += fac.weight
      @decision.alternatives.each do |alt|
        rank = tmp_ranks.find { |r|
          r.alternative_id == alt.id && r.factor_id == fac.id
        }
        if ! rank
          rank = Ranking.new
          rank.alternative_id = alt.id
          rank.factor_id = fac.id
          rank.weight_id = Level::Medium
          rank.save!
        end
        @rankings[[alt.id,fac.id]] = rank
        points[alt.id] += rank.weight * fac.weight
      end
    end
    minPts,maxPts = points.minmax_by { |key,val| val }
    minPts = minPts[1]
    maxPts = maxPts[1] 
    ptsPerLevel = (maxPts - minPts) / (Level::Count - 1.0)
    @scores = {}
    @decision.alternatives.each do |alt|
      if minPts == maxPts
        level = Level::Count - 1
      else
        ptsAboveMin = points[alt.id] - minPts
        level = ptsAboveMin / ptsPerLevel
        puts "\n\n\n#{alt.id} rates #{level}"
      end
      @scores[alt.id] = level
      @colors[alt.id] = Level.goodColors[level].name
    end
    max *= Level::Count
    @percents = Hash.new 0
    points.map { |key, val| @percents[key] = val * 100.0 / max }
    @alternatives = @decision.alternatives.sort_by!{ |alt| -points[alt.id] }
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
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @decision }
    end
  end

  # GET /decisions/1/edit
  def edit
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
    # since they are on the edit form
    @alternative = Alternative.new
    @factor = Factor.new
  end

end

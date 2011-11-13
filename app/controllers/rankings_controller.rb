class RankingsController < ApplicationController

  before_filter :get_ranking

  # PUT /rankings/1
  # PUT /rankings/1.json
  def update
    respond_to do |format|
      if @ranking.update_attributes(params[:ranking])
        format.html { redirect_to decision_path @ranking.factor.decision, notice: 'Ranking was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @decision.errors, status: :unprocessable_entity }
      end
    end
  end


  ##############################
  ##                          ##
  ##  PRIVATE METHODS BELOW!  ##
  ##                          ##
  ##############################


  private

  def get_ranking
    @ranking = Ranking.find params[:id]
    @ranking = nil if ! can_access @ranking
  end

end

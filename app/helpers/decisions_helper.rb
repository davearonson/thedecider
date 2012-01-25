module DecisionsHelper
  def set_decision_view_stuff
    @title = 'Edit Decision'
    @show_all = @user && @user.is_admin?
    max = 0
    tmp_ranks = Ranking.where(factor_id: @decision.factors.map(&:id)).
                        where(alternative_id: @decision.alternatives.map(&:id))
    @rankings = {}
    points = Hash.new 0
    @weightNames = {}
    @decision.factors.each do |fac|
      fac.weight_id = Level::Medium if ! fac.weight_id
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
    max *= Level::Count

    @scores = {}
    @percents = Hash.new 0
    ptsPerLevel = (max + 1.0) / Level::Count
    if points.length > 0
      @decision.alternatives.each do |alt|
        level = (points[alt.id] / ptsPerLevel).to_i
        @scores[alt.id] = level
      end
      points.map { |key, val| @percents[key] = val * 100.0 / max }
    else
      @decision.alternatives.map do |alt|
        @percents[alt.id] = 0
        @scores[alt.id] = Level::Medium
      end
    end
  end
end

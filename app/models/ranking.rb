class Ranking < ActiveRecord::Base

  belongs_to :alternative

  def user_id
    alternative.decision.user_id
  end

  def weight
    weight_id ? weight_id : Level::Medium
  end

end

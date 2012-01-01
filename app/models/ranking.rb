class Ranking < ActiveRecord::Base

  belongs_to :alternative
  belongs_to :factor

  # just in case -- "design for evil clients"
  validates_presence_of :alternative
  validates_presence_of :factor

  attr_accessible :weight_id

  def user_id
    alternative.decision.user_id
  end

  def weight
    weight_id ? weight_id : Level::Medium
  end

end

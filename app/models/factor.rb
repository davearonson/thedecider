class Factor < ActiveRecord::Base

  belongs_to :decision

  has_many :rankings, :dependent => :destroy

  validates :name, :length => { :minimum => 2, :maximum => 20 },
            :presence => true
            # :uniqueness => true -- NOT YET, NEED TO SCOPE W/IN DECISION!

  def user_id
    decision ? decision.user_id : nil
  end

  def weight
    weight_id ? weight_id : Level::Medium
  end
end

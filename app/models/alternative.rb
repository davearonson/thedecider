class Alternative < ActiveRecord::Base

  belongs_to :decision

  # just in case -- "design for evil clients"
  validates_presence_of :decision_id

  has_many :rankings, :dependent => :destroy

  # this has security applied in controller; see can_access call
  attr_accessible :decision_id

  attr_accessible :name
  validates :name, :length => { :minimum => 2, :maximum => 20 },
            :presence => true
            # :uniqueness => true -- NOT YET, NEED TO SCOPE W/IN DECISION!


  def user_id
    decision ? decision.user_id : nil
  end

end

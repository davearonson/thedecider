class Factor < ActiveRecord::Base

  belongs_to :decision

  # just in case -- "design for evil clients"
  validates_presence_of :decision_id

  has_many :rankings, :dependent => :destroy

  # this has security applied in controller; see can_access call
  attr_accessible :decision_id

  attr_accessible :name, :weight_id
  validates :name, :length => { :minimum => 2, :maximum => 20 },
            :presence => true
            # :uniqueness => true -- NOT YET, NEED TO SCOPE W/IN DECISION!
  validates :weight_id, :numericality => { :only_integer => true,
                                           :greater_than_or_equal_to => Level::Very_Low,
                                           :less_than_or_equal_to => Level::Very_High },
            :presence => true

  def user_id
    decision ? decision.user_id : nil
  end

  def weight
    weight_id ? weight_id : Level::Medium
  end
end

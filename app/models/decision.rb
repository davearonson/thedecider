class Decision < ActiveRecord::Base

  belongs_to :user

  # just in case -- "design for evil clients"
  validates_presence_of :user

  # this has security applied in controller; see can_access call
  attr_accessible :user_id

  has_many :alternatives, :dependent => :destroy
  has_many :factors, :dependent => :destroy

  attr_accessible :name
  validates :name, :length => { :minimum => 2, :maximum => 20 },
            :presence => true,
            :uniqueness => true

end

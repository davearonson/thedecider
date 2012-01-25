class Decision < ActiveRecord::Base

  belongs_to :user

  # just in case -- "design for evil clients"
  validates_presence_of :user_id

  # this has security applied in controller; see can_access call
  attr_accessible :user_id

  has_many :alternatives, :dependent => :destroy
  has_many :factors, :dependent => :destroy
  has_many :rankings, :through => :alternatives  # could also say thru factors

  accepts_nested_attributes_for :alternatives, :factors, :rankings, :allow_destroy => true

  attr_accessible :alternatives_attributes, :factors_attributes, :rankings_attributes

  attr_accessible :name
  validates :name, :length => { :minimum => 2, :maximum => 50 },
            :presence => true,
            :uniqueness => true

  attr_accessible :public

  def public?
    @public
  end

end

class Decision < ActiveRecord::Base

  belongs_to :user

  has_many :alternatives, :dependent => :destroy
  has_many :factors, :dependent => :destroy

  validates :name, :length => { :minimum => 2, :maximum => 20 },
            :presence => true,
            :uniqueness => true

end

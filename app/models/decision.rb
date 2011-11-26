class Decision < ActiveRecord::Base

  belongs_to :user

  has_many :alternatives, :dependent => :destroy
  has_many :factors, :dependent => :destroy

  validates_presence_of :name

end

class Decision < ActiveRecord::Base
  belongs_to :user
  has_many :alternatives
  has_many :factors
end

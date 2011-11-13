class Alternative < ActiveRecord::Base

  belongs_to :decision

  has_many :rankings

  validates_presence_of :name

  def user_id
    decision.user_id
  end

end

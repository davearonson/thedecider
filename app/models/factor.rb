class Factor < ActiveRecord::Base
  belongs_to :decision
  def user_id
    decision.user_id
  end
end

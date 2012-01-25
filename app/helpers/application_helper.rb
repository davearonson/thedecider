module ApplicationHelper

  def can_access obj
    if obj && current_user && ( obj.user_id == current_user.id || current_user.is_admin? )
      true
    else
      respond_to do |format|
        format.html { redirect_to root_path,
                      notice: "No peeking at other people's stuff!" }
      end
      false
    end
  end

  def get_user
    @user = user_signed_in? ? current_user : nil
  end

  def title
    @title ? @title : ''
  end

end

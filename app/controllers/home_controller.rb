class HomeController < ApplicationController
  def welcome
    @user = user_signed_in? ? current_user : nil
  end

end

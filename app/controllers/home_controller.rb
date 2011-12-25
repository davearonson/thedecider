class HomeController < ApplicationController

  def about
    @title = 'About This Site'
  end

  def welcome
    @title = 'Welcome!'
    if current_user
      respond_to do |format|
        format.html { redirect_to decisions_path }
      end
    end
  end

end

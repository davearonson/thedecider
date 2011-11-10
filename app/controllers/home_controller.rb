class HomeController < ApplicationController
  def welcome
    @title = "Welcome #{ @user ? @user.username : "Visitor" }!"
  end
end

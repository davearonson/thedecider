class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_filter :authenticate_user!, except: [:about, :welcome]
  before_filter :get_user
  protect_from_forgery
end

class DashboardController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  end
  
  private
  def authenticate_user!
    redirect_to(:action=>"new", :controller=>"devise/sessions") unless user_signed_in?
  end
end

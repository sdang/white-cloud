class DashboardController < ApplicationController
  before_filter :authenticate_user!, :authorized_user!
  before_filter :set_last_uri
  
  def index
  end
  

end

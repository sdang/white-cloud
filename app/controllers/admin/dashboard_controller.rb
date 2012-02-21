class Admin::DashboardController < ApplicationController
  before_filter :authenticate_user!, :authorized_user!, :authenticate_admin!
  
  def index
  end
  
end

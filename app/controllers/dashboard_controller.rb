class DashboardController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  end
  
  private
  def authenticate_user!
    if user_signed_in?
      # check if authorized
      unless current_user.authorized?
        reset_session
        flash[:alert] = "You have not been authorized to use this site, please contact the department of medicine for approval"
        redirect_to(:action=>"new", :controller=>"/devise/sessions")
      end
    else
      redirect_to(:action=>"new", :controller=>"/devise/sessions") unless user_signed_in?
    end
  end
end

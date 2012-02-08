class ApplicationController < ActionController::Base
  protect_from_forgery
  
  layout :layout_by_resource

  def layout_by_resource
    if user_signed_in?
      "application"
    else
      "devise"
    end
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

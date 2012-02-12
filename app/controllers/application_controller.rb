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

  # check if user is authorized
  def authorized_user!
    # cache in memory so we don't keep hitting the db
    session[:authorized] = current_user.authorized? if session[:authorized] == nil
      
    unless session[:authorized]
      reset_session
      flash[:alert] = "You have not been authorized to use this site, please contact the department of medicine for approval"
      redirect_to(:action=>"new", :controller=>"/devise/sessions")
    end
  end

  def authenticate_admin!
    # cache in memory so we don't keep hitting the db
    session[:admin] = current_user.admin? if session[:admin] == nil
    
    unless session[:admin]
      flash[:alert] = "You are not authorized in this area"
      redirect_to session[:last_uri]
    end
  end
      
  # set the last uri session
  def set_last_uri
    session[:last_uri] = request.fullpath
  end
  
end

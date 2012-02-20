class Admin::UsersController < ApplicationController
    before_filter :authenticate_user!, :authorized_user!, :authenticate_admin!
    
    def index
    end
    
    def make_admin
      @user = User.find(params[:id])
      @user.update_attribute(:admin, true)
      ApplicationLog.write("promoted to administrator", 5, @user.id)
      redirect_to :action => "index", :controller => "/admin/dashboard"
    end
    
    def authorize
      @user = User.find(params[:id])
      @user.update_attribute(:authorized, true)
      ApplicationLog.write("is set to be an authorized user", 2, @user.id)
      redirect_to :action => "index", :controller => "/admin/dashboard"
    end
    
    def revoke
      @user = User.find(params[:id])
      @user.update_attribute(:authorized, false)
      @user.update_attribute(:admin, false)
      ApplicationLog.write("access has been revoked", 2, @user.id)
      redirect_to :action => "index", :controller => "/admin/dashboard"
    end
    
    def revoke_admin
      @user = User.find(params[:id])
      @user.update_attribute(:admin, false)
      ApplicationLog.write("is no longer an administrator", 3, @user.id)      
      redirect_to :action => "index", :controller => "/admin/dashboard"
    end
    
    
end
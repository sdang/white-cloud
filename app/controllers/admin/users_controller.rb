class Admin::UsersController < ApplicationController
    before_filter :authenticate_user!, :authorized_user!, :authenticate_admin!
    
    def index
    end
    
    def make_admin
      @user = User.find(params[:id])
      @user.update_attribute(:admin, true)
      
      redirect_to :action => "index", :controller => "/admin/dashboard"
    end
    
    def authorize
      @user = User.find(params[:id])
      @user.update_attribute(:authorized, true)
      
      redirect_to :action => "index", :controller => "/admin/dashboard"
    end
    
    def revoke
      @user = User.find(params[:id])
      @user.update_attribute(:authorized, false)
      @user.update_attribute(:admin, false)
      redirect_to :action => "index", :controller => "/admin/dashboard"
    end
    
    def revoke_admin
      @user = User.find(params[:id])
      @user.update_attribute(:admin, false)
      
      redirect_to :action => "index", :controller => "/admin/dashboard"
    end
    
    
end
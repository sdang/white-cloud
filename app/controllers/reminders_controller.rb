class RemindersController < ApplicationController
  before_filter :authenticate_user!, :authorized_user!
  before_filter :set_last_uri, :only => ["index"]
  def index
  end
  
  def create
    @reminder = Reminder.new(params[:reminder])
    @reminder.user_id = current_user.id
    @reminder.save
    
    respond_to do |format|
      format.html { redirect_to '/' }
      format.js
    end
  end
  
  def destroy
    @reminder = Reminder.find_by_id(params[:id])
    @reminder.update_attribute(:completed, true)
    
    respond_to do |format|
      format.html { redirect_to '/' }
      format.js
    end
  end
  
  def cancel_edit
    @reminder = Reminder.find_by_id(params[:id])
    respond_to do |format|
      # format.html { redirect_to :controller => "/reminders", :action => "index" }
      format.js
    end
  end
  
  def edit
    @reminder = Reminder.find_by_id(params[:id])
    
    respond_to do |format|
      format.html { redirect_to '/' }
      format.js
    end
  end
  
  
end

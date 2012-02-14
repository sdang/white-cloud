class RemindersController < ApplicationController
  before_filter :authenticate_user!, :authorized_user!
  before_filter :set_last_uri, :only => ["index"]

  def index
  end
  
  def update
    @error = false
    @reminder = Reminder.find_by_id(params[:id])
    @reminder.update_attributes(params[:reminder])
    respond_to do |format|
      format.html { redirect_to '/' }
      format.js
    end
  end
  
  def create_by_string
    @reminder = Reminder.create_from_string(params[:string], current_user.id)
    
    respond_to do |format|
      format.html { redirect_to :controller => "/reminders" }
      format.js
    end
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

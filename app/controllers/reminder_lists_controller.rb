class ReminderListsController < ApplicationController
  before_filter :authenticate_user!, :authorized_user!, :authenticate_admin!

  before_filter :set_last_uri, :only => ["index"]

  def index
  end
  
  def update
    @reminder_list = ReminderList.find_by_id(params[:id])
    @reminder_list.update_attributes(params[:reminder_list])
    respond_to do |format|
      format.html { redirect_to '/' }
      format.js
    end
  end
  
  def create
    @reminder_list = ReminderList.new(params[:reminder_list])
    @reminder_list.save
    
    respond_to do |format|
      format.html { redirect_to '/' }
      format.js
    end
  end
  
  def destroy
    @reminder_list = ReminderList.find_by_id(params[:id])
    @reminder_list.destroy if @reminder_list.reminders.find_all_by_completed(false).size == 0
    
    respond_to do |format|
      format.html { redirect_to :controller => "/admin/dashboard" }
      format.js
    end
  end
  
  def cancel_edit
    @reminder_list = ReminderList.find_by_id(params[:id])
    respond_to do |format|
      # format.html { redirect_to :controller => "/reminders", :action => "index" }
      format.js
    end
  end
  
  def edit
    @reminder_list = ReminderList.find_by_id(params[:id])
    
    respond_to do |format|
      format.html { redirect_to '/' }
      format.js
    end
  end
  
end

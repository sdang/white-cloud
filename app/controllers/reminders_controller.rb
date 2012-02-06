class RemindersController < ApplicationController
  
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
    @reminder.destroy
    
    respond_to do |format|
      format.html { redirect_to '/' }
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

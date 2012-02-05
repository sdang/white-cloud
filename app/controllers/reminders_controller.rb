class RemindersController < ApplicationController
  
  def create
    @reminder = Reminder.new(params[:reminder])
    @reminder.save
    respond_to do |format|
      format.html { redirect_to '/' }
      format.js
    end
  end
  
end

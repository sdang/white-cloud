class RemindersController < ApplicationController
  
  def create
    @reminder = Reminder.new(params[:reminder])
    @reminder.save
    redirect_to '/'
  end
  
end

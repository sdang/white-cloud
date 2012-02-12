class ReminderListsController < ApplicationController
  before_filter :authenticate_user!, :authorized_user!
  
end

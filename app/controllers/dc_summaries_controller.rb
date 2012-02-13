class DcSummariesController < ApplicationController
  before_filter :authenticate_user!, :authorized_user!
  before_filter :set_last_uri, :only => ["index"]
  
  def index
  end
  
  def create
  end
  
  def edit
  end
  
  def destroy
  end
  
  
end
class DcSummariesController < ApplicationController
  before_filter :authenticate_user!, :authorized_user!
  before_filter :set_last_uri, :only => ["index", "edit"]
  
  def index
  end
  
  def create
    @dc_summary = current_user.dc_summaries.new(params[:dc_summary])
    if @dc_summary.save
      redirect_to :action => "edit", :id => @dc_summary.id
    else
      render :action => "index"
    end
    
  end
  
  def edit
    @dc_summary = DcSummary.find_by_id(params[:id])
  end
  
  def update
    @dc_summary = DcSummary.find_by_id(params[:id])
    @dc_summary.last_update_user_id = current_user.id
    if @dc_summary.update_attributes(params[:dc_summary])
      flash[:notice] = 'Successfully Saved Changes'
      redirect_to :action => "edit", :id => @dc_summary.id
    else 
      flash.now[:alert] = 'Error saving d/c summary'
      render :action => edit
    end
  end
  
  def destroy
  end
  
  
end
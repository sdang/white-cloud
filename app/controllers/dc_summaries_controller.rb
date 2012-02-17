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
    @prescription = Prescription.new
  end
  
  def update
    @dc_summary = DcSummary.find_by_id(params[:id])
    @dc_summary.last_update_user_id = current_user.id
    if @dc_summary.update_attributes(params[:dc_summary])
      flash[:notice] = 'Successfully Saved Changes'
      redirect_to :controller => "dc_summaries", :action => "show", :id => @dc_summary.id
    else 
      # flash.now[:alert] = 'Error saving d/c summary'
      @prescription = Prescription.new
      render :controller => "dc_summaries", :action => "edit", :id => @dc_summary.id
    end
  end
  
  def destroy
    # only destroy if no real data is saved in it
  end
  
  def show
    @dc_summary = DcSummary.find_by_id(params[:id])

    # you should not be able to view this d/c summary unless its finalized
    if @dc_summary.finalized == false or @dc_summary.can_be_finalized? == false
      redirect_to :controller => "dc_summaries", :action => "edit", :id => @dc_summary.id
    end
  end
  
  def prescriptions
    require "prawn/measurement_extensions"
    redirect_to :action => "edit", :id => params[:id] unless session[:group_password]
    prawnto :prawn => {
              :left_margin => 0.5.send(:in), 
              :right_margin => 0.5.send(:in),
              :top_margin => 0.5.send(:in),
              :bottom_margin => 0.5.send(:in),
              :page_layout => :landscape}
              
    @dc_summary = DcSummary.find_by_id(params[:id])
    
    respond_to do |format|
      format.html { redirect_to :action => "prescriptions", :id => @dc_summary.id, :format => :pdf }
      format.pdf
    end
  end
  
  
end
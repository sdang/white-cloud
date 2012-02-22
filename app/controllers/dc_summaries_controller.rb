class DcSummariesController < ApplicationController
  before_filter :authenticate_user!, :authorized_user!
  before_filter :authenticate_admin!, :only => ["unfinalize"]
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
    @consult = Consult.new(:dc_summary_id => @dc_summary.id)
    
    if @dc_summary.finalized
      redirect_to :action => "show", :id => @dc_summary.id
    end
  end
  
  def update
    @dc_summary = DcSummary.find_by_id(params[:id])
    
    # redirect to edit if this is a finalized dc summary
    if @dc_summary.finalized
      flash[:alert] = "Cannot update this discharge summary, it is finalized"
      redirect_to :action => "show", :id => @dc_summary.id
      return
    else 
      @dc_summary.admin_override = true
    end
    
    @dc_summary.last_update_user_id = current_user.id
      
    @prescription = Prescription.new
    @consult = Consult.new(:dc_summary_id => @dc_summary.id)
    
    begin
      @dc_summary.update_attributes(params[:dc_summary])
    rescue ActiveRecord::ReadOnlyRecord
      @dc_summary.errors[:base] << "this d/c summary has been marked read-only"
      respond_to do |format|
        format.html {redirect_to :action => "edit", :id => @dc_summary.id}
        format.js
      end
      
      return
    end
    
    # due to a bug in strongbox, we have to iterate through 
    # parameters, if empty string, directly set object to nil
    ["diagnoses", "condition", "diet", "activity", "discharge_orders", 
        "hospital_course", "hpi", "follow_up", "dc_instructions", "chief_complaint", 
        "one_liner", "procedures", "disposition"].each do |attribute|
      @dc_summary[:"#{attribute}"] = nil if params["dc_summary"][attribute].blank?
      logger.warn "cleared #{attribute}" if params["dc_summary"][attribute].blank?
    end
    @dc_summary.save
    
    respond_to do |format|
      format.html { 
        if @dc_summary.errors.any?
          render :controller => "dc_summaries", :action => "edit", :id => @dc_summary.id, :alert => "Error Saving D/C Summary"
        else
          redirect_to :action => "edit", :id => @dc_summary.id, :notice => 'Successfully Saved Changes' 
        end
      }
      format.js
    end
  end

  
  def destroy
    # only destroy if no real data is saved in it
    flash[:alert] = "Deleting discharge summaries is not supported"
    respond_to do |format|
      format.js { render :nothing }
      format.html { redirect_to :action => "index" }
    end
  end
  
  def show
    @dc_summary = DcSummary.find_by_id(params[:id])
  end
  
  def prescriptions
    require "prawn/measurement_extensions"
    redirect_to :action => "index" unless session[:group_password]
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
  
  def consults
    
    require "prawn/measurement_extensions"
    redirect_to :action => "index" unless session[:group_password]
    prawnto :prawn => {
      :left_margin => 0.5.send(:in),
      :right_margin => 0.5.send(:in),
      :top_margin => 0.75.send(:in),
      :bottom_margin => 0.75.send(:in),
      :page_layout => :portrait
    }
    
    @dc_summary = DcSummary.find_by_id(params[:id])
    
    respond_to do |format|
      format.html { redirect_to :action => "consults", :id => @dc_summary.id, :format => :pdf }
      format.pdf
    end
    
  end
  
  def unfinalize
    @dc_summary = DcSummary.find_by_id(params[:id])
    
    # we have to toggle off read-only
    @dc_summary.admin_override = true
    @dc_summary.update_attribute(:finalized, false)
    
    redirect_to :action => "edit", :id => @dc_summary.id
  end
  
  def import_handler
    # update the dc summary with the required data, handles:
    # rx, one_liner, diagnoses for now
    @dc_summary = DcSummary.find_by_id(params[:id])
    @prefix = params[:prefix]
    if params[:prefix] == "rx"
      @update_result = @dc_summary.import_rx(session[:group_password])
    elsif params[:prefix] == "one_liner"
      @update_result = @dc_summary.import_one_liner(session[:group_password])
    elsif params[:prefix] == "diagnoses"
      @update_result = @dc_summary.import_diagnoses(session[:group_password])
    else
      @update_result = false
    end
    
    respond_to do |format|
      format.html { redirect_to :action => "edit", :id => @dc_summary.id }
      format.js
    end
    
  end
  
  
end
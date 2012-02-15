class PrescriptionsController < ApplicationController
  before_filter :get_dc_summary, :except => ["destroy", "edit"]
  
  def create
    @prescription = @dc_summary.prescriptions.new(params[:prescription])
    @prescription.save
    respond_to do |format|
      format.html { redirect_to :controller => "/dc_summaries", :action => "edit", :id => params[:dc_summary_id] }
      format.js
    end
  end

  def edit
    @prescription = Prescription.find(params[:id])
  end
  
  def update
    @prescription = Prescription.find(params[:id])
    @prescription.update_attributes(params[:prescription])
    
    respond_to do |format|
      format.html { redirect_to @dc_summary }
      format.js
    end
  end

  def destroy
    @prescription = Prescription.find(params[:id])
    @prescription.destroy
    
    respond_to do |format|
      format.html { redirect_to @dc_summary }
      format.js
    end
  end
  
  private
  def get_dc_summary
    unless params[:prescription][:dc_summary_id]
      flash[:alert] = "Critical error, could not attach prescription to d/c summary."
      redirect_to :controller => "/dc_summaries", :action => "index"
    end
    
    @dc_summary = DcSummary.find(params[:prescription][:dc_summary_id])
  end

end

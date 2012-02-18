class ConsultsController < ApplicationController
  before_filter :get_dc_summary, :except => ["destroy", "edit"]
  
  def create
    @consult = @dc_summary.consults.new(params[:consult])
    @consult.save
    respond_to do |format|
      format.html { redirect_to :controller => "/dc_summaries", :action => "edit", :id => params[:dc_summary_id] }
      format.js
    end
  end

  def edit
    @consult = Consult.find(params[:id])
  end
  
  def update
    @consult = Consult.find(params[:id])
    @consult.update_attributes(params[:consult])
    
    respond_to do |format|
      format.html { redirect_to @dc_summary }
      format.js
    end
  end

  def destroy
    @consult = Consult.find(params[:id])
    @consult.destroy
    
    respond_to do |format|
      format.html { redirect_to @dc_summary }
      format.js
    end
  end
  
  private
  def get_dc_summary
    unless params[:consult][:dc_summary_id]
      flash[:alert] = "Critical error, could not attach consult to d/c summary."
      redirect_to :controller => "/dc_summaries", :action => "index"
    end
    
    @dc_summary = DcSummary.find(params[:consult][:dc_summary_id])
  end

end

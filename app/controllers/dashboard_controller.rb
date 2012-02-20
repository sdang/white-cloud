class DashboardController < ApplicationController
  before_filter :authenticate_user!, :authorized_user!
  before_filter :set_last_uri
  
  def index
  end
  
  def search
    mrn = params[:mrn]
    
    if mrn.match(/[^0-9]/) or mrn.blank?
      flash[:alert] = "Please provide a 7 digit MRN to search for patient"
      redirect_to :action => "index"
    else
      @reminders = Reminder.find_all_by_mrn(mrn)
      @dc_summaries_open = DcSummary.find(:all, :conditions => ["finalized = ? AND mrn = ?", false, mrn], :order => "updated_at DESC")
      @dc_summaries_finalized = DcSummary.find(:all, :conditions => ["finalized = ? AND mrn = ?", true, mrn], :order => "updated_at DESC")
    end
    
  end
  

end

class PhiController < ApplicationController
    before_filter :authenticate_user!
    
    
    def unlock_phi
      # create a test object and test the validity of group pw (totally clunky, but works)
      dc = DcSummary.new(:hospital_course => "test")
      begin
        if dc.hospital_course.decrypt(params[:group_password]) == "test"
          session[:group_password] = params[:group_password]
          flash[:notice] = "PHI Unlocked, please log out when you are complete"
          logger.debug "PHI Unlocked"
          logger.debug session[:last_uri]
          redirect_to session[:last_uri]
        end
      rescue
        logger.debug "Failed Group PW"
        flash[:alert] = "Invalid group password, unable to unlock PHI. Please try again."
        redirect_to session[:last_uri]
      end
    end
    
end
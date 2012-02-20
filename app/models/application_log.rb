class ApplicationLog < ActiveRecord::Base

  belongs_to  :user
  
  def self.write(msg,level=0,user_id=nil)

    al = ApplicationLog.new(:message => msg, :level => level, :user_id => user_id)
    al.save
    AdminMailer.send_critical_log_notice(al.id).deliver if level == 5
    return al
    
  end
  
  def self.recent_logs
    return ApplicationLog.find(:all, :order => "created_at DESC", :limit => 50)
  end
  
end


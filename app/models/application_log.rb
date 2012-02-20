class ApplicationLog < ActiveRecord::Base

  belongs_to  :user
  
  def self.write(msg,level=0,user_id=nil)
    return ApplicationLog.new(:message => msg, :level => level, :user_id => user_id).save
  end
  
  def self.recent_logs
    return ApplicationLog.find(:all, :order => ["created_at ASC"], :limit => 50)
  end
  
end


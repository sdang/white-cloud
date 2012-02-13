class User < ActiveRecord::Base
  has_many :reminders
  has_many :dc_summaries, :foreign_key => :created_user_id
  
  validates_presence_of :first_name, :last_name
  
  validates_format_of :pager_number,
      :message => "must be a valid telephone number.",
      :with => /^[\(\)0-9\- \+\.]{10,20}$/
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :pager_number, 
        :first_name, :last_name, :remind_by_sms, :remind_by_email

  serialize :preferences  
  
  def reminder_list
    self.reminders.find_all_by_completed(false, :order => "remind_time ASC")
  end
  
  def dc_summaries_list
    self.dc_summaries.find_all_by_finalized(false)
  end
  
  def authorized?
    return self.authorized rescue false
  end
  
  def admin?
    return self.admin rescue false
  end
  
  def pager_number=(num)
    write_attribute(:pager_number, User.phone_str_to_num(num))
  end
  
  def sms_number=(num)
    write_attribute(:sms_number, User.phone_str_to_num(num))
  end
  
  def self.find_by_pager_number(num)
    User.where("pager_number = ?", phone_str_to_num(num)).limit(1).first
  end
  
  def self.find_by_sms_number(num)
    User.where("sms_number = ?", phone_str_to_num(num)).limit(1).first
  end

  # preferences quick functions
  def remind_by_email
    return false if self.read_attribute("preferences")[:remind_by_email] == ""
    return self.read_attribute("preferences")[:remind_by_email] || false
  end
  
  def remind_by_sms
    return false if self.read_attribute("preferences")[:remind_by_sms] == ""
    return self.read_attribute("preferences")[:remind_by_sms] || false
  end
  
  def default_reminder_list_id
    return self.read_attribute("preferences")[:default_reminder_list_id] || ReminderList.find(:first).id
  end
  
  def remind_by_email=(val)
    self.preferences ||= {}
    self.preferences[:remind_by_email] = val
  end
  
  def remind_by_sms=(val)
    self.preferences ||= {}
    self.preferences[:remind_by_sms] = val
  end
  
  def default_reminder_list_id=(val)
    self.preferences ||= {}
    rl = ReminderList.find_by_id(val)
    if rl
      self.preferences[:default_reminder_list_id] = val
    else
      raise "Tried to set a default reminder list to one that doesn't exist"
    end
  end
  
  def default_reminder_list
    return ReminderList.find_by_id(self.default_reminder_list_id)
  end
    
  private
  def self.phone_str_to_num(str)
    str = str.gsub(/[^0-9]/,'')
    return str.match(/[2-9][0-9]{9}/).to_s
  end
end

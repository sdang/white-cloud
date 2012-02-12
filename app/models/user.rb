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
  attr_accessible :email, :password, :password_confirmation, :remember_me, :pager_number, :first_name, :last_name
  
  def reminder_list
    self.reminders.find(:all, :order => "remind_time ASC")
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
  
  def pager_number
    if read_attribute(:pager_number)
      return ("1" + read_attribute(:pager_number).gsub(/[^0-9]/,'')).to_i
    else
      return nil
    end
  end
  
  def sms_number
    if read_attribute(:sms_number)
      return ("1" + read_attribute(:sms_number).gsub(/[^0-9]/,'')).to_i
    else
      return nil
    end
  end
  
end

class User < ActiveRecord::Base
  has_many :reminders
  has_many :dc_summaries, :foreign_key => :created_user_id
      
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
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
  
end

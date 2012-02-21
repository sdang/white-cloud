require 'test_helper'

class ReminderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "create time from time val and time units" do
    current_time = Time.now
    r = Reminder.new(:mrn => "1111111", :reminder => "test", :time_value => 3, :time_units => 24)
    r.save
    assert (r.remind_time > current_time+3.days-1.minutes and r.remind_time < current_time+3.days+1.minutes), "incorrect reminder time from time val and units"
  end
  
  test "test invalid mrn" do
    current_time = Time.now
    r = Reminder.new(:mrn => "hello dolly", :reminder => "test", :remind_time => current_time)
    assert !r.save, "created reminder wtihout valid mrn"
  end
  
  test "reminder without a time" do
    r = Reminder.new(:mrn => "1231234", :reminder => "test")
    assert !r.save, "created reminder without a time"
  end
  
  test "send reminder for a completed reminder" do
    
    r1 = Reminder.find(reminders(:one))
    r1.user_id = User.find(users(:one)).id
    r1.save
    r1_last_notification = r1.last_notification

    
    Reminder.send_reminders
    
    r1 = Reminder.find(reminders(:one))
    assert_not_equal r1.last_notification, r1_last_notification, "did not update last_notificate on reminder"
    r1_last_notification = r1.last_notification

    Reminder.send_reminders
    
    r1 = Reminder.find(reminders(:one))    
    assert_equal r1.last_notification, r1_last_notification, "set a reminder to the same user twice"
  end
  
end

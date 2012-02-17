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
  end
  
  test "reminder without a time" do
  end
  
  test "send reminder for a completed reminder" do
  end
  
end

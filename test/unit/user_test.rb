require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "create user without valid pager" do
    u = User.new
    u.first_name = "First Name"
    u.last_name = "Last Name"
    u.pager_number = "My Pager"
    assert !u.save, "saved user with invalid pager id"
  end
  
  test "query default preferences for new user" do
    u = User.new
    assert_kind_of(ReminderList, u.default_reminder_list, "new user did not return a valid reminder list")
    assert !u.remind_by_email, "new user defaults to send email reminders"
    assert !u.remind_by_sms, "new user defaults to send sms reminders"
  end
  
  test "verify default credentials for new user" do
    u = User.new
    assert !u.admin?
    assert !u.authorized?, "new user defaults to authorized"
  end
  
  test "string phone number to integer store" do
    u = User.new
    u.pager_number = "+1 (818) 555-1212"
    assert_equal(u.pager_number, "8185551212", "text phone number does not convert to numbers only")
  end

    
end

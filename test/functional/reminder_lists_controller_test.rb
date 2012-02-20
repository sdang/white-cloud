require 'test_helper'

class ReminderListsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "create without user id" do
    rl = ReminderList.new(:name => "test")
    assert !rl.save, "saved reminder list without assigning it to a supervisor"
  end
  
  test "create without name" do
    rl = ReminderList.new(:user_id => 1)
    assert !rl.save, "saved reminder list without a name"
  end
  
  test "create two with same name" do
    rl = ReminderList.new(:name => "test", :user_id => 1)
    rl.save
    rl2 = ReminderList.new(:name => "test", :user_id => 1)
    assert !rl.save, "saved two reminder lists with the same name"
  end
end

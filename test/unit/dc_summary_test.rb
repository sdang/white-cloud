require 'test_helper'

class DcSummaryTest < ActiveSupport::TestCase

  test "prevent save of finalized d/c summary" do
    dc = DcSummary.new(:first_name => "First", :last_name => "last", :mrn => "1231234", :created_user_id => 1, :finalized => 1)
    dc.save
    dc.first_name = "New Name"
    assert !dc.save, "saved a finalized d/c summary"
  end
  
  test "invalid mrn" do
    dc = DcSummary.new(:first_name => "First", :last_name => "Last", :mrn => "MRN", :created_user_id => 1)
    assert !dc.save, "saved d/c summary with invalid MRN"
  end
  
  test "data gets encrypted" do
    assert_raise(OpenSSL::PKey::RSAError) {
      dc = DcSummary.new
      dc.first_name = "First"
      assert_not_equal(dc.first_name.decrypt('debunk_pw'),"First", "PHI not encrypted on attribute set")
    }
  end
  
  test "user method for dc summary" do
    u1 = User.find(users(:one))
    u2 = User.find(users(:two))

    dc = DcSummary.new(:first_name => "test", :last_name => "lastname", :mrn => "0001234", :dob => Time.now)
    dc.created_user_id = u1.id
    dc.last_update_user_id = nil
    dc.save

    assert_equal(dc.created_user_id, u1.id, "Could not set created_user_id")
    assert_equal(dc.user.id, u1.id, "User method did not return created user for new dc summary")
    dc.last_update_user_id = u2.id
    assert_equal(dc.user.id, u2.id, "User method did not return last updated user for updated dc summary")
  end
  
  test "save dc summary without user id" do
    dc = DcSummary.new(:first_name => "test", :last_name => "last_name", :dob => Time.now, :mrn => "0000000")
    assert !dc.save, "saved d/c summary without user id"
  end
    
end

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
    assert !dc.save, "saved dc/ summary with invalid MRN"
  end
  
  test "data gets encrypted" do
    assert_raise(OpenSSL::PKey::RSAError) {
      dc = DcSummary.new
      dc.first_name = "First"
      assert_not_equal(dc.first_name.decrypt('debunk_pw'),"First", "PHI not encrypted on attribute set")
    }
  end
    
end

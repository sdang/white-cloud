require 'test_helper'

class PrescriptionTest < ActiveSupport::TestCase

  test "save without attaching to dc summary" do
    p = Prescription.new
    p.dc_summary = nil
    assert !p.save, "saved prescription without d/c summary"
  end
  
  test "prescription gets printed" do
    p = Prescription.new(:drug => "lasix")
    assert !p.print?, "printed prescription without sig or quantity"
    
    p = Prescription.new(:drug => "Lasix", :sig => "1 tab po bid")
    assert !p.print?, "printed prescription without quantity"
    
    p = Prescription.new(:drug => "Lasix", :quantity => "3 months")
    assert !p.print?, "printed prescription without sig"
  end
  
  
end

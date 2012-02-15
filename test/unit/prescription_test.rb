require 'test_helper'

class PrescriptionTest < ActiveSupport::TestCase

  test "save without attaching to dc summary" do
    p = Prescription.new
    p.dc_summary = nil
    assert !p.save, "saved prescription without d/c summary"
  end
end

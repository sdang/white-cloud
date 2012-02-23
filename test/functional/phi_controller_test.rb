require 'test_helper'

class PhiControllerTest < ActionController::TestCase
  test "unlock phi" do
    sign_in User.find(users(:one).id)

    post "unlock_phi", :group_password => ENV["GROUP_PW"]
    assert_response :redirect, "Did not redirect after unlocking phi"
    
    assert_equal("PHI unlocked. Please log out when you are complete", flash[:notice], "group password did not unlock phi")
  end
  
  test "unlock phi with bad pw" do
    sign_in User.find(users(:one).id)

    post "unlock_phi", :group_password => "123123123"
    assert_response :redirect, "Did not redirect after unlocking phi"
    
    assert_equal("Invalid group password, unable to unlock PHI. Please try again.", flash[:alert], "bad group password unlocked phi")
  end
  
  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

end



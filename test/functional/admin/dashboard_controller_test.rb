require 'test_helper'

class Admin::DashboardControllerTest < ActionController::TestCase
  
  test "should redirect away from admin area" do
    sign_in User.find(users(:two).id)
    
    get :index
    assert_response :redirect, "Accessed admin area without admin credentials"
  end
  
  test "allow access to administrators" do
     sign_in User.find(users(:one).id)
     
     get :index
     assert_response :success
  end
  
  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
  
end

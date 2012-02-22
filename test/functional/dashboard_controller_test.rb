require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "should redirect to login" do
    get :index
    assert_redirected_to :action=>"new", :controller=>"/devise/sessions"

    get :search
    assert_redirected_to :action=>"new", :controller=>"/devise/sessions"
  end
  
  test "should render login" do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in User.find(users(:two).id)
    
    get :index
    assert_response :success, "Could not load dashboard#index"
  end
  
  test "should redirect non-authorized user to login" do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in User.find(users(:three).id)
    
    get :index
    assert_redirected_to :action=>"new", :controller=>"/devise/sessions"
  end
  
end

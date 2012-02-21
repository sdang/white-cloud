require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "should redirect to login" do
    get :index
    assert_redirected_to :action=>"new", :controller=>"/devise/sessions"

    get :search
    assert_redirected_to :action=>"new", :controller=>"/devise/sessions"
  end
  
end

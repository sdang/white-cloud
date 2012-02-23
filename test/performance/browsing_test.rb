require 'test_helper'
require 'rails/performance_test_help'

class BrowsingTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  self.profile_options = { :runs => 5, :metrics => [:wall_time, :memory],
                          :output => 'tmp/performance', :formats => [:flat] }

  def test_homepage
    get "/users/sign_in"
    assert_response :success
 
    post_via_redirect "/users/sign_in", :user => {:email => users(:one).email, :password => "fdxfdx1"}
 
    get "/"
    assert_response :success

    get "/admin/dashboard"
    assert_response :success
  end
    
end

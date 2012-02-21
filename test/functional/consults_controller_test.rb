class ConsultsControllerTest < ActionController::TestCase

  test "should redirect to login" do
    post :create
    assert_redirected_to :action=>"new", :controller=>"/devise/sessions"

  end

end
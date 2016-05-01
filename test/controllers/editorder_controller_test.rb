require 'test_helper'

class EditorderControllerTest < ActionController::TestCase
  test "should get showinvited" do
    get :showinvited
    assert_response :success
  end

  test "should get showjoined" do
    get :showjoined
    assert_response :success
  end

  test "should get remove" do
    get :remove
    assert_response :success
  end

end

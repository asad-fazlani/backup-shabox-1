require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get home_index_url
    assert_response :success
  end

  test "should get privacy_policy" do
    get home_privacy_policy_url
    assert_response :success
  end
end

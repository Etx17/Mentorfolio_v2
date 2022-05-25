require "test_helper"

class MeetingControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get meeting_new_url
    assert_response :success
  end

  test "should get create" do
    get meeting_create_url
    assert_response :success
  end
end

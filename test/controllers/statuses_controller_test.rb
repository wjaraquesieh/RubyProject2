require "test_helper"

class StatusesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get statuses_index_url
    assert_response :success
  end

  test "should get show" do
    get statuses_show_url
    assert_response :success
  end
end

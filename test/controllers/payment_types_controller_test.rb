require "test_helper"

class PaymentTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get payment_types_index_url
    assert_response :success
  end

  test "should get show" do
    get payment_types_show_url
    assert_response :success
  end
end

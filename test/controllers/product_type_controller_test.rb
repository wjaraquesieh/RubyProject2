require "test_helper"

class ProductTypeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get product_type_index_url
    assert_response :success
  end
end

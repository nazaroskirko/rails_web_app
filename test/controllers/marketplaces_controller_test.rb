require 'test_helper'

class MarketplacesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get marketplaces_index_url
    assert_response :success
  end

end

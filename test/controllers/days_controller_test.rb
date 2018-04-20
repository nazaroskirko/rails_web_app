require 'test_helper'

class DaysControllerTest < ActionDispatch::IntegrationTest
  test "should get check" do
    get days_check_url
    assert_response :success
  end

end

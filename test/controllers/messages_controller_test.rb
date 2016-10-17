require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get incoming" do
    get messages_incoming_url
    assert_response :success
  end

  test "should get outgoing" do
    get messages_outgoing_url
    assert_response :success
  end

end

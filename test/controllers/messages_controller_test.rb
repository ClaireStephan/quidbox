require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @message = messages(:one)
  end

  test "should get list posted and public" do
    get messages_url, as: :json
    assert_response :success
    body = JSON.parse(@response.body)
    assert_equal 1, body.length
  end

  test "should get list with user: draft from" do
    get messages_url({user: 'B_User'}), as: :json
    assert_response :success
    body = JSON.parse(@response.body)
    assert_equal 4, body.length
  end

  test "should get list with user: posted private" do
    get messages_url({user: 'A_User'}), as: :json
    assert_response :success
    body = JSON.parse(@response.body)
    assert_equal 3, body.length
  end

  test "should create message" do
    assert_difference('Message.count') do
      post messages_url, params: { message: { body: @message.body, from: @message.from, private: @message.private, to: @message.to } }, as: :json
    end
    assert_response 201
  end

  test "should publish message" do
    publish_message = messages(:three)
    #check not posted 
    assert_nil publish_message.posted
    #post it and check answer
    put message_url(publish_message.id)
    assert_response 200
    #reload and validate it has been posted
    publish_message.reload
    assert_not_nil publish_message.posted
  end

  test "should not change message already published" do
    published_message = messages(:six)
    #check posted and save it
    assert_not_nil published_message.posted
    init = published_message.posted.dup
    #repost it and check answer
    put message_url(published_message.id)
    assert_response 200
    #reload and validate it hasn't change
    published_message.reload
    assert_equal init, published_message.posted
  end

#  test "should not publish unknown message" do
#    id = 1111
    #post fake id and check answer
#    put message_url(id)
#     rescue_from ActiveRecord::RecordNotFound, :with => { assert_response 404 }
#  end

end

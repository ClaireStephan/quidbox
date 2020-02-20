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
    #assert_equal messages(:five).body, body[0].body
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

#  test "should create message" do
 #   assert_difference('Message.count') do
  #    post messages_url, params: { message: { body: @message.body, from: @message.from, private: @message.private, to: @message.to } }, as: :json
   # end
    #assert_response 201
#  end

#  test "should publish message" do
 #   get messages_url({user: 'publish_user'}), as: :json
  #  assert_response :success
   # body = JSON.parse(@response.body)
    #puts body[0]['id']
#    put messages_url, params: { id: 1018350795 }, as: :json
 #  assert_response 200
  #  assert_not_empty JSON.parse(@response.body['posted'])
  #end

#  test "should not change message already published" do
 #   get messages_url({user: 'C_user'}), as: :json
  #  assert_response :success
   # body = JSON.parse(@response.body)
#    puts body
 #   put messages_url(body['id']), as: :json
  #  assert_response 200
   # assert_equal JSON.parse(@response.body['posted']), messages(:five).posted
  #end

end

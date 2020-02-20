require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  test "message should be valid" do
    message = Message.new(from: 'A', to: 'B', body: 'message', private: true)
    assert message.valid?
  end

  test "should not save message without private" do
    message = Message.new(from: 'A', to: 'B', body: 'message')
    assert_not message.valid?
    assert_not message.save
    message.private = true
    assert message.valid?
  end

  test "should not save message without body" do
    message = Message.new(from: 'A', to: 'B', private: true)
    assert_not message.valid?
    assert_not message.save
    message.body = 'body'
    assert message.valid?
  end

  test "should not save message without to" do
    message = Message.new(from: 'A', body: 'message', private: true)
    assert_not message.valid?
    assert_not message.save
    message.to = 'B'
    assert message.valid?
  end

  test "should not save message without from" do
    message = Message.new(to: 'B', body: 'message', private: true)
    assert_not message.valid?
    assert_not message.save
    message.from = 'A'
    assert message.valid?
  end

  puts 'message test pass'
end

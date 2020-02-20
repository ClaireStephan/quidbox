require 'time'
class MessagesController < ApplicationController
  before_action :set_message, only: [:publish, :destroy]

  # GET /messages
  def list
    messages_public = Message.where(private: false).merge(Message.where.not(posted: nil))
    # TODO should be based on authenticated user instead of a param
    if params[:user].present?
      messages_from = Message.where(from: params[:user])
      messages_to = Message.where(to: params[:user]).merge(Message.where.not(posted: nil))
      @messages = messages_public.or(messages_from.or(messages_to))
    else
      @messages = messages_public
    end
    render json: @messages
  end

  # POST /messages
  def create
    @message = Message.new(message_params)
    if @message.save
      render json: @message, status: :created, location: @messages
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # PUT /messages/1
  def publish
    if @message.posted
      render json: @message
    elsif @message.update_column(:posted,Time.now.getutc)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:message).permit(:from, :to, :body, :private)
    end
end

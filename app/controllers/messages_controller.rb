require 'time'

class MessagesController < ApplicationController
  include Swagger::Docs::ImpotentMethods

  before_action :set_message, only: [:update, :destroy]

  # GET /messages
  def index
    messages_public = Message.where(private: false).merge(Message.where.not(posted: nil))
    # TODO should be done by default based on authenticated user instead of a param
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
  def update
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

  #############
  ## SWAGGER ##
  #############
  swagger_controller :messages, "Quidbox Message Management"
 
  swagger_api :index do
    summary "List messages"
    notes "By default only public posted messages are returned.
    User parameter can be used as an alternative to authentication, 
    if provided private posted messages related to the user (from or to)
    and draft messages from the user are also returned"
    param :query, :user, :string, :optional, "User ID"
    response :ok
    response :unprocessable_entity
    response :not_found
  end
  swagger_api :create do
    summary "Create a message"
    param :form, "message[from]", :string, :required, "From"
    param :form, "message[to]", :string, :required, "To"
    param :form, "message[body]", :string, :required, "Body"
    param :form, "message[private]", :boolean, :required, "Private"
    response :created
    response :bad_request
    response :unprocessable_entity
    response :not_found
  end
  swagger_api :update do
    summary "Post a message"
    notes "This fill the posted field. It will be done only the first time"
    param :path, :id, :integer, :required, "Message ID"
    response :ok
    response :unprocessable_entity
    response :not_found
  end
  swagger_api :destroy do
    summary "Delete a message"
    param :path, :id, :integer, :required, "Message ID"
    response :no_content
    response :not_found
  end

  #############
  #############

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      # TODO check that the authenticated user is the :from retrieved
      @message = Message.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:message).permit(:from, :to, :body, :private)
    end
end

class ConversationsController < ApplicationController
  before_action :authenticate_user!
  def create
    @user = User.friendly.find(params[:user_id])
    @conversation = Conversation.get(current_user.id, @user.id)
    
    add_to_conversations unless conversated?

    respond_to do |format|
      format.js
    end
  end

  def close
    @conversation = Conversation.find(params[:id])

    session[:conversations].delete(@conversation.id)

    respond_to do |format|
      format.js
    end
  end

  private

  def add_to_conversations
    session[:conversations] ||= []
    session[:conversations] << @conversation.id
  end

  def conversated?
    session[:conversations].include?(@conversation.id)
  end
end
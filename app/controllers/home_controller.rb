class HomeController < ApplicationController
	before_action :authenticate_user!, only: [:chats]
  def index
  end

  def privacy_policy
  end

  def chats
  	session[:conversations] ||= []
    @users = User.all.where.not(id: current_user)
    @conversations = Conversation.includes(:recipient, :messages)&.find(session[:conversations])
  end
end

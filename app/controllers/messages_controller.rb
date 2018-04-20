class MessagesController < ApplicationController
  before_action :set_conversation, only: [:create]

  def create
    receipt = current_user.reply_to_conversation(@conversation, params[:body])
    flash[:success] = "Your message has been sent"
    redirect_to messages_path
  end

  private
  def set_conversation
    @conversation = current_user.mailbox.conversations.find(params[:conversation_id])
  end
end

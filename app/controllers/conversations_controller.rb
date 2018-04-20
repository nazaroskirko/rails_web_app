class ConversationsController < ApplicationController
  before_action :logged_in_user
  def index
    messages = []
    receipts = []
    conversations = current_user.mailbox.conversations
    conversations.each do |conversation|
      conversation.receipts_for(current_user).each do |receipt|
        unless receipt.message.sender_id == current_user.id
          new_message = receipt.message
          messages << receipt.message
          receipts << receipt
        end
      end
    end
    grouped_messages = messages.group_by{|m| m.created_at.strftime("%a, %b %-d")}
    # @messages = messages.collect do |message|
    #     {:subject => "sample subject"}
    # end
    @grouped = grouped_messages
    @receipts = receipts
    email_json = {}
    email_json["emails"] = []
    email_array = []
    grouped_messages.each do |key, array|
      day_group = {}
      day_group["group"] = key
      day_group["list"] = []
      array.each do |message|
        info = {}
        info["id"]= message.id,
        info["conversation_id"] = message.conversation_id,
        info["subject"]= message.subject,
        info["to"]= [User.find(message.sender_id).full_name],
        info["body"]= message.body,
        info["time"]= message.created_at.strftime('%l%p'),
        info["datetime"]= "#{message.created_at.strftime('%a-%d')} at #{message.created_at.strftime('%l%p')}",
        info["from"]= User.find(Mailboxer::Conversation.find(message.conversation_id).receipts.where(mailbox_type: "inbox").first.receiver_id).full_name,
        info["dp"]= "assets/img/profiles/avatar.jpg",
        info["dpRetina"]= "assets/img/profiles/avatar2x.jpg"
        day_group["list"] << info
      end
      email_json["emails"] << day_group
    end
    render json: email_json
  end

  def create
    recipient = User.find(params[:user_id])
    current_user.send_message(recipient, params[:body], params[:subject])
    flash[:success] = "You message has been sent."
    redirect_to messages_path
  end

  def new
    @recipients = (current_user.doctors + current_user.patients).uniq
    respond_to do |format|
      format.js {}
    end
  end

  def reply
    @conversation = current_user.mailbox.conversations.find(params[:conversation_id])
    respond_to do |format|
      format.js
    end
  end

end

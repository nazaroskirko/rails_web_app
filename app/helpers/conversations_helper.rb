module ConversationsHelper

  def get_recipient_name conversation
    if conversation.sender_id == current_user
      recipient = User.find(conversation.recipient_id)
      "#{recipient.first_name} #{recipient.last_name}"
    else
      recipient = User.find(conversation.sender_id)
      "#{recipient.first_name} #{recipient.last_name}"
    end
  end
end

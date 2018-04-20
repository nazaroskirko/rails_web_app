module TodoListHelper

  def formatCheckBox item_id
    checked = TodoItem.find(item_id).completed ? "checked" : ""
    "<div class='checkbox'><form class='edit_todo_item' id='edit_todo_item_#{item_id}' action='/users/#{current_user.id}/todo_lists/#{TodoItem.find(item_id).todo_list_id}/todo_items/#{item_id}' accept-charset='UTF-8' data-remote='true' method='post'><input name='utf8' type='hidden' value='✓'><input type='hidden' name='_method' value='patch'><input name='todo_item[completed]' type='hidden' value='0'><input id='todo_item_completed_#{item_id}' class='completed-checkbox' type='checkbox' value='1' name='todo_item[completed]' #{checked}><label class='nosee completed-checkbox' for='todo_item_completed_#{item_id}' #{checked}>Completed</label></form></div>".html_safe
  end




  def formatEditButton list_id, item_id, htsafe=true
    if htsafe
    "<button id='#{item_id}' class='btn edit-todo' data-item-id='#{item_id}' data-target='#modalSlideLeft' data-toggle='modal' data-url='/users/#{current_user.id}/todo_lists/#{list_id}/todo_items/#{item_id}/edit'><i class='fa fa-edit'></i></button>".html_safe
  else
    "/users/#{current_user.id}/todo_lists/#{list_id}/todo_items/#{item_id}/edit"
  end
  end

  def formatDescription description
    unless description.blank?
      description
    else
      " "
    end
  end

  def formatDeadline deadline
    deadline.strftime("%b %d") unless deadline.nil?
  end
end

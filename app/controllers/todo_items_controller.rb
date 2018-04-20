class TodoItemsController < ApplicationController
  before_action :logged_in_user
  def edit
      @item = TodoItem.find(params[:id])
      @list = TodoList.find(params[:todo_list_id])
      respond_to do |format|
        format.js
      end
  end

  def update
    @item = TodoItem.find(params[:id])
    @response = @item.update_attributes(item_params)
    respond_to do |format|
      format.js
    end
  end

  private

  def item_params
    params.require(:todo_item).permit(:title, :todo_list_id, :description, :completed)
  end

end

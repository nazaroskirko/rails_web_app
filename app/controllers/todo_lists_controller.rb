class TodoListsController < ApplicationController
  before_action :logged_in_user
  def show
  end

  def new
    @list = TodoList.new
    @item = @list.todo_items.build
    respond_to do |format|
      format.js
    end
  end

  def create
    @list = TodoList.find_or_create_by(user_id: current_user.id, title: params[:todo_list][:title])
    @response = @list.update_attributes(list_params)
    @item = @list.todo_items.last if @response
    respond_to do |format|
      format.html {@response ? redirect_to(user_todo_lists_path current_user, flash: {success: "List Updated"}) : render(action: "index", flash: {warning: "There was an error when saving your items."})}
      format.js {@response ? flash.now[:notice] = 'One more thing to do...' : flash.now[:error] = "Oops, you missed something."}
    end
  end

  def edit
    @list = Todolist.find(params[:item])
    @item = @list.todo_items
    respond_to do |format|
      format.js
    end

  end

  def  update
    list = TodoList.find_or_create_by(user_id: current_user.id, title: params[:todo_list][:title])
    item = TodoItem.find(params[:todo_list]["todo_items_attributes"]["0"][:id])
    item.todo_list_id = list.id
    item.save
    @response = list.update_attributes(list_params)
    @list = TodoList.find(list.id)
    @item = TodoItem.find(params[:todo_list]["todo_items_attributes"]["0"][:id])
    respond_to do |format|
      format.html {@response ? redirect_to(user_todo_lists_path current_user, flash: {success: "List Updated"}) : render(action: "index", flash: {warning: "There was an error when saving your items."})}
      format.js {@response ? flash.now[:notice] = 'One more thing to do...' : flash.now[:error] = "Oops, you missed something."}
    end
  end

  def index
    @lists = current_user.todo_lists
    @array_of_list_titles = @lists.pluck(:id, :title)
    @items = []
    @lists.each do |l|
      l.todo_items.each do |i|
        @items << i
      end
    end
  end

  private

  def list_params
    params.require(:todo_list).permit(:title, todo_items_attributes: [:id, :title, :description, :deadline])
  end

end

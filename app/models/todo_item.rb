class TodoItem < ApplicationRecord
  belongs_to :todo_list, inverse_of: :todo_items
  validates :title, presence: true

end

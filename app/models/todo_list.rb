class TodoList < ApplicationRecord
  has_many :todo_items, dependent: :destroy, inverse_of: :todo_list
  belongs_to :user
  validates :title, presence: true
  accepts_nested_attributes_for :todo_items
end

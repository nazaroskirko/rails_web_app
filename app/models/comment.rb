class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  serialize :content, Hash

  def parse_content
  	
  end
end

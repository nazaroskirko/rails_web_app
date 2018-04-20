class AddPaperclipToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_attachment :documents, :image
  end
end

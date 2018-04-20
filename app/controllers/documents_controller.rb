class DocumentsController < ApplicationController

  def create
    @document = Document.new(document_params)

    if @document.save
      redirect_to patients_user_path(current_user), notice: 'Document was successfully created.'
    else
      render :nothing => true, :status => 400
    end
  end

  private
    def document_params
      params.require(:document).permit(:application, :image, :user_id)
    end

end

class CommentsController < ApplicationController
  before_filter :load_commentable
  before_action :logged_in_user
  def index
    @comments = @commentable.comments
  end

  def new
    @commentable = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
      respond_to do |format|
        format.js
      end

  end

  private

  def load_commentable
    klass = [User,Appointment].detect {|c| params["#{c.name.underscore}_id"]}
    @commentable = klass.find(params["#{klass.name.underscore}_id"])
  end

  def comment_params
    params.require(:comment).permit(:content => [:type, :simple, :subjective_complaint, :objective_findings, :assessment_of_progress, :plans_for_next_session,
                                                        :data, :assessment_and_response, :plan])
  end
end

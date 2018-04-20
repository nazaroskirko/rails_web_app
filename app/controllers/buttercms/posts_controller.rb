class Buttercms::PostsController < Buttercms::BaseController
  layout :resolve_layout
  def index
    @posts = ButterCMS::Post.all(:page => params[:page], :page_size => 9)

    @next_page = @posts.meta.next_page
    @previous_page = @posts.meta.previous_page
  end

  def show
    @post = ButterCMS::Post.find(params[:slug])
  end

  private

  def resolve_layout
    "layouts/buttercms/default"
  end
end

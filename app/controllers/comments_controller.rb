class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable

  def new
    @comment = Comment.new
  end

  def create
    if params[:blog_id].present?
      @blog = Blog.friendly.find(params[:blog_id])
      blog_id = @blog.id
    elsif @commentable.commentable_type == "Blog"
      @blog = Blog.find_by_id(@commentable.commentable_id)
      blog_id = @blog.id
    else
      blog_id = Comment.friendly.find(@commentable.commentable_id).blog_id
      @blog = Blog.friendly.find(@commentable.blog_id)
    end
    @comment = @commentable.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.blog_id = blog_id
    if @comment.save

      redirect_to @blog, notice: 'Your comment was successfully posted!'
    else
      redirect_to @blog, notice: "Your comment wasn't posted!"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_commentable
    @commentable = Comment.friendly.find(params[:comment_id]) if params[:comment_id]
    @commentable = Blog.friendly.find(params[:blog_id]) if params[:blog_id]
  end

end


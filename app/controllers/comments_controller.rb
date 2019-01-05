class CommentsController < ApplicationController
  
  before_action :authenticate_user!

  def new
    @comment = Comment.new
    @comment.user = current_user
    @comment.post = Post.find(params[:post_id])
  end

  def create
    @comment = Comment.create(content: comment_params[:content], user: current_user, post: Post.find(comment_params[:post_id]))
    @comment.post.group.update(recent_activity: Time.now)
    redirect_to group_post_path(@comment.post.group, @comment.post)
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])

    @comment.update(content: comment_params[:content])
    @comment.post.group.update(recent_activity: Time.now)
    redirect_to group_post_path(@comment.post.group, @comment.post)
  end

  def destroy
    @comment = Comment.find(params[:id])
    post = @comment.post
    @comment.destroy
    @comment.post.group.update(recent_activity: Time.now)
    flash[:notice] = "Comment deleted."
    redirect_to group_post_path(post.group, post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :id)
  end
end

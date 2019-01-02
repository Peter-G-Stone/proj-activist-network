class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @comment.user = current_user
    @comment.post = Post.find(params[:post_id])
  end

  def create
    @comment = Comment.create(content: comment_params[:content], user: current_user, post: Post.find(comment_params[:post_id]))
    redirect_to group_path(@comment.post.group)
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])

    @comment.update(content: comment_params[:content])
    redirect_to group_path(@comment.post.group)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "Comment deleted."
    redirect_to group_path(@comment.post.group)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :id)
  end
end

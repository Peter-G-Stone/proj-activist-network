class CommentController < ApplicationController
  def new
    @comment = Comment.new
    @comment.user = current_user
    @comment.post = Post.find(params[:post_id])
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

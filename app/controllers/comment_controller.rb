class CommentController < ApplicationController
  def new
    @post = Post.new
        @post.user = current_user
        @post.group = Group.find(params[:group_id])
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

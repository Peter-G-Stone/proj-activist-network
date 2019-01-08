class CommentsController < ApplicationController
  
  before_action :authenticate_user! 
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :user_is_authorized?, only: [:edit, :update, :destroy]

  def new
    @comment = Comment.new
    @comment.user = current_user
    @comment.post = Post.find(params[:post_id])
  end

  def create
    @comment = Comment.new(content: comment_params[:content], user: current_user, post: Post.find(comment_params[:post_id]))
    if @comment.save
      @comment.post.group.update(recent_activity: Time.now)
      redirect_to group_post_path(@comment.post.group, @comment.post)
    else
      flash[:error] = @comment.errors.full_messages[0]
      redirect_to new_post_comment_path(@comment.post)
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(content: comment_params[:content])
      @comment.post.group.update(recent_activity: Time.now)
      redirect_to group_post_path(@comment.post.group, @comment.post)
    else
      flash[:error] = @comment.errors.full_messages[0]
      redirect_to edit_post_comment_path(@comment.post, @comment)
    end
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

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def user_is_authorized?
    unless current_user == @comment.user
      flash[:notice] = "You aren't allowed to do that!"
      redirect_to group_post_path(@comment.post.group, @comment.post) 
    end
  end
end

class PostsController < ApplicationController

    before_action :authenticate_user!
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :user_is_authorized?, only: [:edit, :update, :destroy]

    def new
        @post = Post.new
        @post.user = current_user
        @post.group = Group.find(params[:group_id])
    end

    def create
        @post = Post.new(content: post_params[:content], group: Group.find(post_params[:group_id]), user: current_user)
        if @post.save
            # @post.group.update(recent_activity: Time.now)
            redirect_to group_path(@post.group)
        else
            messages = ""
            flash[:notice] = @post.errors.full_messages.map {|msg| messages + msg + ". "}[0]
            redirect_to new_group_post_path(post_params[:group_id])
        end
    end

    def edit
    end

    def update
        if @post.update(content: post_params[:content])
            redirect_to group_path(@post.group)
        else
            messages = ""
            flash[:notice] = @post.errors.full_messages.map {|msg| messages + msg + ". "}[0]
            redirect_to edit_group_post_path(post_params[:group_id])
        end 
    end 

    def show
    end

    def destroy
        @post.comments.each {|c| c.destroy}
        @post.group.update(recent_activity: Time.now)
        @post.destroy
        flash[:notice] = "Post deleted."
        redirect_to group_path(@post.group)
    end

    private

    def post_params
        params.require(:post).permit(:content, :group_id, :id)
    end

    def set_post
        @post = Post.find(params[:id])
    end

    def user_is_authorized?
        flash[:notice] = "You aren't allowed to do that!"
        redirect_to group_post_path(@post.group, @post) unless current_user == @post.user
    end
end

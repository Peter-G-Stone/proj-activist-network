class PostsController < ApplicationController

    before_action :authenticate_user!


    def new
        @post = Post.new
        @post.user = current_user
        @post.group = Group.find(params[:group_id])
    end

    def create
        @post = Post.new(content: post_params[:content], group: Group.find(post_params[:group_id]), user: current_user)
        if @post.save
            redirect_to group_path(@post.group)
        else
            messages = ""
            flash[:notice] = @post.errors.full_messages.map {|msg| messages + msg + ". "}[0]
            redirect_to new_group_post_path(post_params[:group_id])
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])

        if @post.update(content: post_params[:content])
            redirect_to group_path(@post.group)
        else
            messages = ""
            flash[:notice] = @post.errors.full_messages.map {|msg| messages + msg + ". "}[0]
            redirect_to edit_group_post_path(post_params[:group_id])
        end 
    end 

    def show
        @post = Post.find(params[:id])
    end

    def destroy
        @post = Post.find(params[:id])
        @post.comments.each {|c| c.destroy}
        @post.destroy
        flash[:notice] = "Post deleted."
        redirect_to group_path(@post.group)
    end

    private

    def post_params
        params.require(:post).permit(:content, :group_id, :id)
    end
end

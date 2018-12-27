class PostsController < ApplicationController

    def new
        @post = Post.new
        @post.user = current_user
        @post.group = Group.find(params[:group_id])
    end

    def create
        @post = Post.create(content: post_params[:content], group: Group.find(post_params[:group_id]), user: current_user)
        redirect_to group_path(@post.group)
    end

    def destroy
        binding.pry
        @post = Post.find(params[:id])
    end

    private

    def post_params
        params.require(:post).permit(:content, :group_id)
    end
end

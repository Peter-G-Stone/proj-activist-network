class ProfilesController < ApplicationController

    before_action :set_user, only: [:show, :edit, :update]
    before_action :authenticate_user!



    def index
        @users = User.all
    end
  
    def show
      @user_groups = @user.groups
      @user_posts = @user.posts 
      @user_comments = @user.comments 
    end
   
    def edit  
    end
  
    def update
      @user.update(user_params)
      redirect_to user_path
    end



    private
      def user_params
        params.require(:user).permit(:name, :bio, :uid)
      end
  
      def set_user
        @user = User.find(params[:id])
      end
  
  end
  # binding.pry
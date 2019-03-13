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
   
   
    def search # note -- there's no search bar in the layout rn bc I'm refactoring. add one back!
      @users = User.where("name LIKE ?", "%#{params[:user_name_q]}%")
      if @users.empty?
        flash.now[:error] = "No results found for '#{params[:user_name_q]}'!" 
      else
        flash.now[:notice] = "Here are your search results for '#{params[:user_name_q]}'."
      end
      render 'index'
    end


    private
      def user_params
        params.require(:user).permit(:name, :bio, :uid)
      end
  
      def set_user
        @user = User.find(params[:id])
      end
  
  end
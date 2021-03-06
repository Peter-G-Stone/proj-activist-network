class GroupsController < ApplicationController


    before_action :set_group, only: [:show, :edit, :update, :join_group, :leave_group, :destroy]
    before_action :user_is_authorized?, only: [:edit, :update, :destroy]
    before_action :authenticate_user!



    def index
        @groups = Group.all
    end
  
    def show
      # @group is set
      @group_users = @group.users
      @group_posts = @group.posts
      respond_to do |format|
        format.html {render :show }
        format.json {render json: @group.to_json(include: { posts: {include: [:user, :comments]}})}
      end
    end
  
    def new
      @group = Group.new
    end
  
    def create
      @group = Group.new(group_params)
      @group.users << current_user
      if @group.save
        flash[:notice] = "You successfully created a group!"
        redirect_to group_path(@group)
      else
        messages = ""
        flash.now[:notice] = @group.errors.full_messages.map {|msg| messages + msg + ". "}[0]
        render 'new'
      end     
    end
  
    def edit  
    end
  
    def update
      if @group.update(group_params)
        redirect_to group_path(@group.id)
      else
        messages = ""
        flash[:notice] = @group.errors.full_messages.map {|msg| messages + msg + ". "}[0]
        redirect_to edit_group_path(@group.id)
      end
    end

    def destroy
      @group.destroy
      redirect_to groups_path
    end

#-----------------------------------


    def join_group
      @group.users << current_user
      flash[:notice] = "You successfully joined this group."
      redirect_to group_path(@group)
    end

    def leave_group
      @group.users -= [current_user]
      flash[:notice] = "You successfully left this group."
      redirect_to group_path(@group)
    end

    def recently_active
      @groups = Group.active_in_last_hour
      flash.now[:notice] = "These groups were active within the last hour!"
      render 'index'
    end

    def search
      @groups = Group.where("name LIKE ?", "%#{params[:group_name_q]}%")
      if params[:group_name_q] == ''
        flash.now[:error] = "You searched for nothing! That returns everything! Deep."
      elsif @groups.empty?
        flash.now[:error] = "No results found for '#{params[:group_name_q]}'!" 
      else
        flash.now[:notice] = "Here are your search results for '#{params[:group_name_q]}'"
      end
      render 'index'
    end



    private
      def group_params
        params.require(:group).permit(:name, :summary)
      end
  
      def set_group
        @group = Group.find(params[:id])
      end

      def user_is_authorized?
        if !current_user.admin?(@group)
          flash[:notice] = "You aren't allowed to do that!"
          redirect_to group_path(@group) 
        end
      end
  
  end
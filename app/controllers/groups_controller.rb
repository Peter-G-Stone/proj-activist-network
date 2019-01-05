class GroupsController < ApplicationController

    before_action :set_group, only: [:show, :edit, :update, :join_group, :leave_group, :destroy]
    before_action :authenticate_user!



    def index
        @groups = Group.all
    end
  
    def show
      @group_users = @group.users
      @group_posts = @group.posts
    end
  
    def new
      @group = Group.new
    end
  
    def create
      group = Group.create(group_params)
      group.users << current_user
      group.groups_user[0].admin = true
      group.groups_user[0].save
      group.update(recent_activity: Time.now)
      flash[:notice] = "You successfully created a group!"
      redirect_to group_path(group)
    end
  
    def edit  
    end
  
    def update
      @group.update(group_params)
      @group.update(recent_activity: Time.now)
      redirect_to groups_path
    end

    def join_group
      @group.users << current_user
      @group.update(recent_activity: Time.now)
      flash[:notice] = "You successfully joined this group."
      redirect_to group_path(@group)
    end

    def leave_group
      @group.users -= [current_user]
      flash[:notice] = "You successfully left this group."
      redirect_to group_path(@group)
    end

    def destroy
      @group.destroy
      redirect_to groups_path
    end


    private
      def group_params
        params.require(:group).permit(:name, :summary)
      end
  
      def set_group
        @group = Group.find(params[:id])
      end
  
  end
  # binding.pry
class GroupsController < ApplicationController


    before_action :set_group, only: [:show, :edit, :update, :join_group, :leave_group, :destroy]
    before_action :user_is_authorized?, only: [:edit, :update, :destroy]
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
      group = Group.new(group_params)
      group.users << current_user
      if group.save
        group.groups_user[0].admin = true
        group.groups_user[0].save
        group.update(recent_activity: Time.now)
        flash[:notice] = "You successfully created a group!"
        redirect_to group_path(group)
      else
        messages = ""
        flash[:notice] = group.errors.full_messages.map {|msg| messages + msg + ". "}[0]
        redirect_to new_group_path
      end
      
    end
  
    def edit  
    end
  
    def update
      if @group.update(group_params)
        @group.update(recent_activity: Time.now)
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
      @group.update(recent_activity: Time.now)
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



    private
      def group_params
        params.require(:group).permit(:name, :summary)
      end
  
      def set_group
        @group = Group.find(params[:id])
      end

      def user_is_authorized?
        redirect_to group_path(@group) unless current_user.admin?(@group)
      end
  
  end
class GroupsController < ApplicationController

    before_action :set_group, only: [:show, :edit, :update, :join_group, :leave_group]
    before_action :authenticate_user!



    def index
        @groups = Group.all
    end
  
    def show
      @group_users = @group.users
    end
  
    def new
      @group = Group.new
    end
  
    def create
      group = Group.create(group_params)
      redirect_to groups_path(group)
    end
  
    def edit  
    end
  
    def update
      @group.update(group_params)
      redirect_to groups_path
    end

    def join_group
      @group.users << current_user
      redirect_to group_path(@group)
    end

    def leave_group
      @group.users -= [current_user]
      redirect_to group_path(@group)
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
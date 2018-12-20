class GroupsController < ApplicationController

    before_action :set_group, only: [:show, :edit, :update]
    before_action :authenticate_user!



    def index
        @groups = Group.all
    end
  
    def show
    end
  
    def new
      @group = Group.new
    end
  
    def create
    #   attraction = Attraction.create(attraction_params)
    #   redirect_to attraction_path(attraction)
    end
  
    def edit
      
    end
  
    def update
      @group.update(group_params)
      redirect_to groups_path
    end
  
    private
      def group_params
        params.require(:group).permit(:name, :summary)
      end
  
      def set_group
        @group = Group.find(params[:id])
      end
  
      def set_user
        # @user = current_user
      end
  
  end
  
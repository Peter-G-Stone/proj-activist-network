class GroupsController < ApplicationController

    before_action :set_group, only: [:show, :edit, :update]
    before_action :authenticate_user!



    def index
    #   @attractions = Attraction.all
        @groups = Group.all
    end
  
    def show
    end
  
    def new
    #   @attraction = Attraction.new
    end
  
    def create
    #   attraction = Attraction.create(attraction_params)
    #   redirect_to attraction_path(attraction)
    end
  
    def edit
      
    end
  
    def update
  
    #   @attraction.update(attraction_params)
    #   redirect_to attraction_path(@attraction)
    end
  
    private
      def attraction_params
        # params.require(:attraction).permit(:name, :nausea_rating, :happiness, :tickets, :min_height)
      end
  
      def set_group
        @group = Group.find(params[:id])
      end
  
      def set_user
        # @user = current_user
      end
  
  end
  
class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  # GET /friendships
  # GET /friendships.json
  def index
    @users = User.where(id: current_user.id)
  end

  # GET /friendships/1
  # GET /friendships/1.json
  def show
    @users = User.where(id: current_user.id)
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
end

class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js #to make it respond to ajax

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.where(user_id: current_user.id)
    @group = Group.new
    @usgroup = Usgroup.new
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
     @groups = Group.where(user_id: current_user.id)
     @group = Group.new
     @usgroup = Usgroup.new
     @group_current = Group.find_by(:id => params[:id])
     @group_users = Usgroup.where(:group_id => params[:id])

     # @g_users=[]
     # @group_users.each do |grData|
     #    @userDetails=User.find_by(:id => grData['user_id'])
     #    @g_users.push(@userDetails)
     # end
     @friendships = Friendship.where(user_id: current_user.id)

     
  end

  # GET /groups/new
  def new
    @group = Group.new
    # @group = Group.find params[:user_id]
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @groupName = Group.find_by(name: group_params[:name] , user_id: group_params[:user_id])

    if @groupName
      respond_to do |format|
            format.html { redirect_to groups_url, notice: 'Group was Not added.' }
      end
    else
      @group = Group.new(group_params)
      respond_to do |format|
        if @group.save
           format.html { redirect_to controller: 'groups'}
           # format.html { redirect_to @group, notice: 'Group was successfully created.' }
           format.json { render :show, status: :created, location: @group }
        else
          format.html { render :new }
          format.json { render json: @group.errors, status: :unprocessable_entity }
        end
      end
    end

  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :user_id)
    end
end

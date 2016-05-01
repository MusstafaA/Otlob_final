class OrdetailsController < ApplicationController
  before_action :set_ordetail, only: [:show, :edit, :update, :destroy]

  # GET /ordetails
  # GET /ordetails.json
  def index
    @ordetails = Ordetail.all
    redirect_to '/'
  end

  # GET /ordetails/1
  # GET /ordetails/1.json
  def show
    redirect_to '/'
  end

  # GET /ordetails/new
  def new
   
      @order=Order.where(:id => params[:order_id])
      @order=@order[0]
      if @order
          if @order.status != 'finished'  
                  @checkjoined=Ordetail.where(:order_id => @order.id).where(:user_id => current_user.id)
                  @checkfriend=Friendship.where(:user_id =>1)


               # if current_user.id == @order.user_id or @checkjoined.present? 

                   @ordetail = Ordetail.new(order_id: params[:order_id])
                   @ordered_list = Ordetail.where(order_id: params[:order_id] , :user_id => current_user.id).paginate(:page => params[:page], :per_page => 5)
                   @user=User.where(:id => @order.user_id) 
                      
                    @i=0
                    @t=[]
                      
                   @joined=@order.ordetails
                 
                  if    @joined.length != 0

                         @joined.each  do |joined|
                                    
                                 @temp=User.where(:id => joined.user_id)
                                 
                                     if @i == 0
                                            @t[@i]=@temp
                                 
                                            @i=@i+1
                                
                                     else

                                             if @t.include? @temp == false 

                                             
                                               @t[@i]=@temp
                                             
                                               @i=@i+1
                                            
                                            end

                                      end
                          end   
                  end
            else
                @finish_message="Sorry this order is Finished"
            end      

    else          
        @cancel_message="Sorry this order is canceled"
    end   

  end

  # GET /ordetails/1/edit
  def edit
    redirect_to '/'
  end

  # POST /ordetails
  # POST /ordetails.json
  def create
    @ordetail = Ordetail.new(ordetail_params)
    #@ordetail['order_id']= params[:order_id] 
    @ordetail['user_id']= current_user.id

    respond_to do |format|
      if @ordetail.save
          format.html { redirect_to action: "new", order_id: @ordetail['order_id'] }
        # format.html { redirect_to @ordetail, notice: 'Ordetail was successfully created.' }
        # format.json { render :show, status: :created, location: @ordetail }
      else
        format.html { redirect_to action: "new", order_id: @ordetail['order_id'] , notice: @ordetail.errors.messages }
        #format.html { render :new }
        format.json { render json: @ordetail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ordetails/1
  # PATCH/PUT /ordetails/1.json
  def update
    respond_to do |format|
      if @ordetail.update(ordetail_params)
        format.html { redirect_to action: "new", order_id: @ordetail['order_id'] }
        # format.html { redirect_to @ordetail, notice: 'Ordetail was successfully updated.' }
        # format.json { render :show, status: :ok, location: @ordetail }
      else
        format.html { render :edit }
        format.json { render json: @ordetail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ordetails/1
  # DELETE /ordetails/1.json
  def destroy
    @ordetail.destroy
    respond_to do |format|
      format.html { redirect_to action: "new", order_id: @ordetail['order_id'] }
      # format.html { redirect_to ordetails_url, notice: 'Ordetail was successfully destroyed.' }
      # format.json { head :no_content }
    end
  end



  def join
    @actor=User.find_by id: params[:user_id]
    @orderCreator=User.find_by id: params[:creator_id]
    @order=Order.find_by id: params[:order_id]

    if Notification.find_by(actor_id: params[:user_id] , notifiable_id: params[:order_id]).blank?
    # no  record for this id
      Ordetail.create(user_id: params[:user_id] , order_id: params[:order_id])
      Notification.create(recipient: @orderCreator, actor: @actor, action: "joined", notifiable: @order )
      
    else
      # at least 1 record for this id
    end
    redirect_to "/orders/"+params[:order_id]+"/ordetails/new"
    # respond_to do |format|
    #   format.html { redirect_to action: "new", order_id: params[:order_id] }
    # end
 
  end





  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ordetail
      @ordetail = Ordetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ordetail_params

      params.require(:ordetail).permit(:item, :price, :amount, :comment, :user_id, :order_id)

    end
end

class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /orders
  # GET /orders.json

 
  def index
      
     @orders = Order.where(:user_id => current_user.id).paginate(:page => params[:page],  :per_page => 3)
     

  end

  # GET /orders/1
  # GET /orders/1.json
   def show
  @ordetail = Ordetail.new      
  @ordered_list = Ordetail.where(:order_id => params[:id]).paginate(:page => params[:page],  :per_page => 5)  

   @inviteds = Invited.where(:order_id => @order.id)
         
         @invitedall=[]
         @i=0
         @inviteds.each  do |invited|
     
           @invitedall[@i]=User.where(:id => invited.user_id)
           @i=@i+1
  

    end
     @joined =Ordetail.where(:order_id => @order.id)
         
         @joinedall=[]
         @i=0

         @joined.each  do |joined|
               if joined.user_id != @order.user_id 
           @temp=User.where(:id => joined.user_id)
           
               if @i == 0
                      @joinedall[@i]=@temp
           
                     @i=@i+1
          
               else

           if @joinedall.include? @temp == false 

           
             @joinedall[@i]=@temp
           
             @i=@i+1
          
          end

        end

           
     end
  end

  
 @checkjoined=Ordetail.where(:order_id => @order.id).where(:user_id => current_user.id)
  
  @checkfriend=Friendship.where(:user_id => current_user.id).where(:friend_id => @order.user_id)
  @checkinvited=Invited.where(:order_id =>@order.id).where(:user_id => current_user.id )
  
  if current_user.id == @order.user_id or @checkjoined.present? or @checkfriend.present? or @checkinvited.present?
    
     @user=User.where(:id => @order.user_id) 
        
      @i=0
      @t=[]
        
     @joined=@order.ordetails
   
    if    @joined.length != 0

     @joined.each  do |joined|
              if joined.user_id != current_user.id 
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
end   
  else
     
      redirect_to orders_url
  
   end 
      
 
  
end

  # GET /orders/new
  
     def joined 
       
       @joined=current_user.ordetails
       
       @order_ids=[]
       
       @i=0
      
       @joined.each  do |j|
     
         @order_ids[@i]=j.order_id
        
         @i=@i+1
  
     end
    
      @orders=Order.where(:id => @order_ids).paginate(:page => params[:page],  :per_page => 3)

   end 

  def new
  
 
   
    @groups =Group.where(:user_id => current_user.id).as_json
     @order = Order.new
     @friends= current_user.friendships  
     @t=[]
     @i=0
     @friends.each  do |friend|
     
         @t[@i]=User.where(:id => friend.friend_id)
         @i=@i+1
  

    end
 end

  # GET /orders/1/edit
  
 def edit

    @order_id=params[:id]
     
    @ordercheck=Order.where(:id => @order_id ).where(:user_id => current_user.id)
    
    if @ordercheck.present?


     @order = Order.find(params[:id])

     @order['status']='finished'
     
     if @order.save 

         redirect_to orders_url
     else
         redirect_to orders_url
               
      end
    else
           redirect_to orders_url
    end  
  end

  # POST /orders
  # POST /orders.json

  def create
    
    @groups =Group.where(:user_id => current_user.id).as_json
    @friends= current_user.friendships  
    @t=[]
    @i=0
    @friends.each  do |friend|
     
         @t[@i]=User.where(:id => friend.friend_id)
         @i=@i+1
  
    end
    
    @order = Order.new(order_params)
    @order['status']='waiting'
     @order['res_name']= @order['res_name'].strip 
    @inf=@order['infriends']
    @ing=@order['ingroups']
     
      
       

    respond_to do |format|
      
       if @order.save
            
             
               if params.has_key?(:infriends)
          
            params.require(:infriends).each  do |f|
            
                 @invited=Invited.new(:order_id => @order['id'],:user_id => f)
          
                 @invited.save
             
                end
           
           end
            
           if params.has_key?(:ingroups)

             params.require(:ingroups).each  do |f|
                     
                           if Invited.where(:order_id => @order['id']).where(:user_id => f).blank?    
             
                                 @invited=Invited.new(:order_id => @order['id'],:user_id => f)
                       
                                 @invited.save
                                   
                           end

                 end
            end 

            

               
          @inviteds=Invited.where(order_id:@order['id'])
          @inviteds.each do |invited| 
          @inviteduser=User.find_by id: invited.user_id
          Notification.create(recipient: @inviteduser, actor: current_user, action: "invited", notifiable: @order )

        
          end   

              @user_friends= Friendship.where(:friend_id => current_user.id)
              @myfriends=[]
              @i=0
              if @user_friends
                  @user_friends.each  do |friend|             
                       @myfriends[@i]=User.find_by(:id => friend.user_id)
                       @i=@i+1            
                  end

                  @myfriends.each  do |myfriend| 
                        # @notifyfriend=User.find_by id: myfriend.id           
                       Notification.create(recipient:myfriend, actor: current_user, action: "created", notifiable: @order )        
                  end
              end



      
          format.html { redirect_to orders_url , notice: 'Order was successfully created.' }
          format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end

  end
=begin
  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      
       else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end
=end
  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
      
    @order_id=params[:id]
     
    @ordercheck=Order.where(:id => @order_id ).where(:user_id => current_user.id)
                   
    
    if @ordercheck.present? and @ordercheck[0].status == 'waiting'

    @order.destroy

    respond_to do |format|
 
      format.html { redirect_to '/orders', notice: 'Order was successfully destroyed.' }

      format.json { head :no_content }
 
   end
 
  else
   
   redirect_to orders_url 
 end
  
 end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order

       if params[:id] == 'joined'
                 
      redirect_to '/orders/joined/all'
        else
          @order = Order.find(params[:id])
        end
      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:for, :res_name, :avatar, :user_id ,:ingroups ,:infriends ,:page)
    end
end

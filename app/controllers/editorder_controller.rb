class EditorderController < ApplicationController
    #before_action :set_order, only: [:show, :edit, :update, :destroy]
     layout 'application', :except => :getinvited
  before_action :authenticate_user!

  def showinvited
         @order = Order.find(params[:id])  
         @inviteds = Invited.where(:order_id => @order.id)
         
         @t=[]
         @i=0
         @inviteds.each  do |invited|
     
           @t[@i]=User.where(:id => invited.user_id)
           @i=@i+1
  

    end
     
           
               
  end

  def showjoined
      
        @order = Order.find(params[:id]) 
        @joined =Ordetail.where(:order_id => @order.id)
         
         @t=[]
         @i=0

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

  def getinvited
  
         if request.post? 
            
            @data = params[:data].split
                @t=[]
                @i=0

          @data[0].each do |user|

                 @t[@i]=User.where(:id => user)
                 @i=@i+1
            end
         
            respond_to do |format|
                   format.json { render json: @t }
            end 

        end 


  end


def getuser 

     @id   = params[:id]

     @user = User.where(:id => @id)    

end


end

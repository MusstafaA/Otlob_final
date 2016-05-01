class WelcomeController < ApplicationController
  
 before_action :authenticate_user!

def index 
 

    if current_user == nil
    
       redirect_to '/users/sign_in'
    else
    	@all_notfications= Notification.where(recipient: current_user)
    end 

    

   @orders = Order.where(:user_id => current_user.id).limit(5).order(id: :desc)
   @friends  = current_user.friendships


end 



 

end

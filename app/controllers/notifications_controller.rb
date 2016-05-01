class NotificationsController < ApplicationController
	before_action :authenticate_user!

	def index
		@notifications = Notification.where(recipient: current_user).where.not(action: "created").unread 

		@all_notfications= Notification.where(recipient: current_user).paginate(:page => params[:page], :per_page => 5)
		


	end

	def mark_as_read
		@notifications = Notification.where(recipient: current_user).unread 
		@notifications.update_all(read_at: Time.zone.now) 
		render json: {success: true}
	end

	def show

       @notifications = Notification.where(recipient: current_user , action: "created").limit(3).order(id: :desc)
       @activ_feeds=[]

       

        @notifications .each  do |feed|
	     	@details = Hash.new
	     	@details = { "recipient" => feed.recipient,
	           "id" => feed.id,
	           "actor" =>feed.actor.name ,
	           "actorid" => feed.actor.id,
	           "action" => feed.action,
	           "notifiable" => feed.notifiable ,
	           "url" => order_path(feed.notifiable)
	         };

	         @activ_feeds.push(@details)
  
        end



       	respond_to do |format|
       		format.json { render json: @activ_feeds}
       	end

    end



end	
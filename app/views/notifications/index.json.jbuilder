json.array!(@notifications) do |notification|
	json.recipient notification.recipient
	json.id notification.id
	json.actor notification.actor.name
	json.actorid notification.actor.id
	json.action notification.action
	json.notifiable   notification.notifiable 
	json.url order_path(notification.notifiable, anchor: dom_id(notification.notifiable))
end



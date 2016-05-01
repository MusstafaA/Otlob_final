json.extract! @order, :id, :for, :res_name, :avatar, :status, :user_id, :created_at, :updated_at

json.array!(@ordered_list ) do |order|
	json.person order.user_name
	json.item order.item
	json.amount order.amount
	json.price  order.price
	json.comment  order.comment
end



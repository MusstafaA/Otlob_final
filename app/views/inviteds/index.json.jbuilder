json.array!(@inviteds) do |invited|
  json.extract! invited, :id, :user_id, :order_id
  json.url invited_url(invited, format: :json)
end

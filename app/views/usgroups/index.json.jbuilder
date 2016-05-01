json.array!(@usgroups) do |usgroup|
  json.extract! usgroup, :id, :user_id, :group_id
  json.url usgroup_url(usgroup, format: :json)
end

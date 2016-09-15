json.topics do
  json.array!(@topics) do |topic|
    json.extract! topic, :id, :title
    json.url topic_url(topic, format: :json)
  end
end

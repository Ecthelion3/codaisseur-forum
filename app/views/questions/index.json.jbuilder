json.questions do
  json.array!(@all_questions) do |question|
    json.extract! question, :id, :title, :body, :topic, :user, :answers
    json.url question_url(question, format: :json)
  end
end

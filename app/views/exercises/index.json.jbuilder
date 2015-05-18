json.array!(@exercises) do |exercise|
  json.extract! exercise, :id, :name, :category, :content
  json.url exercise_url(exercise, format: :json)
end

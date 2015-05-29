json.array!(@assigned_exercises) do |assigned_exercise|
  json.extract! assigned_exercise, :id
  json.url assigned_exercise_url(assigned_exercise, format: :json)
end

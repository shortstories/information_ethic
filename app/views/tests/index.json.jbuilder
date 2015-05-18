json.array!(@tests) do |test|
  json.extract! test, :id, :name, :category, :content
  json.url test_url(test, format: :json)
end

json.array!(@words) do |word|
  json.extract! word, :id, :value
  json.url word_url(word, format: :json)
end

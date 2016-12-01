json.array!(@test01s) do |test01|
  json.extract! test01, :id, :title, :price
  json.url test01_url(test01, format: :json)
end

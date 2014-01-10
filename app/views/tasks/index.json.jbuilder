json.array!(@tasks) do |task|
  json.extract! task, :id, :name, :url, :status, :level
  json.url task_url(task, format: :json)
end

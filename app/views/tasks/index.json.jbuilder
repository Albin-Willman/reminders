json.array!(@tasks) do |task|
  json.extract! task, :id, :name, :description, :offset, :frequenzy, :recurrance_type
  json.url task_url(task, format: :json)
end

json.extract! request, :id, :name, :cycle, :project_id, :organization_id, :created_at, :updated_at
json.url request_url(request, format: :json)

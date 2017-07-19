json.extract! release_note, :id, :release_date, :note, :created_at, :updated_at
json.url release_note_url(release_note, format: :json)

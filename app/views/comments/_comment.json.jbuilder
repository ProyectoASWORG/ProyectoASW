json.extract! comment, :id, :text, :user_id, :replayedComment_id, :created_at, :updated_at, :points, :contribution_title
json.url comment_url(comment, format: :json)

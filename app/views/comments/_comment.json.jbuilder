json.extract! comment, :id, :text, :user_id, :replayedCommentId, :created_at, :updated_at
json.url comment_url(comment, format: :json)

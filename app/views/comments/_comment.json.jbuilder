json.extract! comment, :id, :text, :idCreator, :replayedCommentId, :created_at, :updated_at
json.url comment_url(comment, format: :json)

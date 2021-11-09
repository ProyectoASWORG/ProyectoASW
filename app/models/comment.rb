class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :contribution

  

  has_many :replays, class_name: "Comment", foreign_key: "replayedComment_id"
  belongs_to :replayedComment, class_name: "Comment", optional: true
end

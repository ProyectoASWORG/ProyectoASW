class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :contribution
  validates :text, presence: true



  has_many :replays, class_name: "Comment", foreign_key: "replayedComment_id"
  belongs_to :replayedComment, class_name: "Comment", optional: true


  has_and_belongs_to_many :voted_users, :class_name => :User
end

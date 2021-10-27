class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable 
    serialize(:voted_contribution_ids, Array)
    serialize(:voted_comment_ids, Array)
    validates :user_name, presence: true, uniqueness: true
    has_many :contributions
    has_many :comments
end

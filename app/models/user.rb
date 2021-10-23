class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable
    serialize(:voted_contribution_ids, Array)
    serialize(:voted_comment_ids, Array)
    has_many :contributions
    has_many :comments
end

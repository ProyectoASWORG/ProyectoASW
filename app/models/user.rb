class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable 
    # serialize :voted_contribution_ids
    # serialize :voted_comment_ids
    has_and_belongs_to_many :voted_contributions ,:class_name => :Contribution 
    has_and_belongs_to_many :voted_comments, :class_name => :Comment 
    validates :user_name, presence: true, uniqueness: true
    validates :encrypted_password, presence: true

    has_many :contributions
    has_many :comments
end

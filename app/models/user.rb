class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :omniauthable, omniauth_providers: [:google_oauth2] 
    # serialize :voted_contribution_ids
    # serialize :voted_comment_ids
    has_and_belongs_to_many :voted_contributions ,:class_name => :Contribution 
    has_and_belongs_to_many :voted_comments, :class_name => :Comment 

    has_many :contributions
    has_many :comments

    def self.create_from_google(email:, full_name:)
      create_with(full_name: full_name).find_or_create_by!(email: email)
    end
end

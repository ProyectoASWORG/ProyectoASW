class Contribution < ApplicationRecord
    validates :title, presence: true
    validates_format_of :url, :allow_nil => true, :allow_blank => true, :with => /(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)? /ix
    belongs_to :user
    has_many :comments
    has_and_belongs_to_many :voted_users, :class_name => :User
end

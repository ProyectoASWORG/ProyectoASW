module ContributionsHelper
    def liked_contribution(contribution_id)
        if !user_signed_in?
            return false
        end
        if current_user.voted_contributions.where(:id => contribution_id).exists?
            true
        end
    end
end

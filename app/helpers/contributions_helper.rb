module ContributionsHelper
    def liked_contribution(contribution_id)
        if !user_signed_in?
            return false
        end
        if current_user.voted_contribution_ids.include?(contribution_id)
            true
        end
    end
end

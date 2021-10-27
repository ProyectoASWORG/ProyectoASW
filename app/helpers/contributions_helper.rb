module ContributionsHelper
    def liked_contribution(contribution_id)
        if current_user.voted_contribution_ids.include?(contribution_id)
            "visibility:hidden;"
        end
    end
end

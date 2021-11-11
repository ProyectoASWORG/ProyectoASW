module CommentsHelper
      def liked_comment(comment_id)
        if !user_signed_in?
            return false
        end
        if current_user.voted_comments.where(:id => comment_id).exists?
            true
        end
      end
end

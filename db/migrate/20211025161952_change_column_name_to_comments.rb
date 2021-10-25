class ChangeColumnNameToComments < ActiveRecord::Migration[6.1]
  def change
    rename_column :comments, :replayedCommentId, :replayedComment_id
  end
end

class AddVotedContributionsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :voted_contribution_ids, :text, array:true
    add_column :users, :voted_comment_ids, :text, array:true
  end
end

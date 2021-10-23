class ChangeIdCreatorToUserIdInComments < ActiveRecord::Migration[6.1]
  def change
    rename_column :comments, :idCreator, :user_id
  end
end

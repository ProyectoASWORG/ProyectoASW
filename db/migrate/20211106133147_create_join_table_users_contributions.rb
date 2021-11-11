class CreateJoinTableUsersContributions < ActiveRecord::Migration[6.1]
  def change
    create_join_table :users, :contributions do |t|
      # t.index [:user_id, :contribution_id]
      # t.index [:contribution_id, :user_id]
    end
    create_join_table :users, :comments do |t|
      
    end
  end
end

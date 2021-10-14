class ChangeUserEmailForUserId < ActiveRecord::Migration[6.1]
  def change
    rename_column :contributions, :user_email, :user_id
  end
end

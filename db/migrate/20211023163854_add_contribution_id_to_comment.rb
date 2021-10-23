class AddContributionIdToComment < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :contribution_id, :string
  end
end

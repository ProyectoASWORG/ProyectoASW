class AddContributionTitleToComment < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :contribution_title, :string
  end
end

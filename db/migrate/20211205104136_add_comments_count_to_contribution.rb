class AddCommentsCountToContribution < ActiveRecord::Migration[6.1]
  def change
    add_column :contributions, :comment_count, :integer, default: 0
  end
end

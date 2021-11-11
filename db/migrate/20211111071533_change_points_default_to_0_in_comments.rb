class ChangePointsDefaultTo0InComments < ActiveRecord::Migration[6.1]
  def change
    change_column :comments, :points, :integer
    change_column_default :comments, :points, 0
  end
end

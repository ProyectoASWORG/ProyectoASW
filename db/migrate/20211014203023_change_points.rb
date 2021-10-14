class ChangePoints < ActiveRecord::Migration[6.1]
  def change
    change_column :contributions, :points, :integer, default: 0
  end
end

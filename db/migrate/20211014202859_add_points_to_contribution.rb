class AddPointsToContribution < ActiveRecord::Migration[6.1]
  def change
    add_column :contributions, :points, :integer
  end
end

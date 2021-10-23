class AddPointsToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :points, :string
  end
end

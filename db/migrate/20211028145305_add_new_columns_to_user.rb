class AddNewColumnsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :karma, :integer, :default => 0
    add_column :users, :about, :string, :default => ""

    add_column :users, :show_dead, :boolean, :default => false
    add_column :users, :no_procrast, :boolean, :default => false
    add_column :users, :max_visit, :integer, :default => 20
    add_column :users, :min_away, :integer, :default => 180
    add_column :users, :delay, :integer, :default => 0
  end
end

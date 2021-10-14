class DeleteContributions < ActiveRecord::Migration[6.1]
  def change
    drop_table :contributions
  end
end

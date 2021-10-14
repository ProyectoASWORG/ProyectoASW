class CreateContributions < ActiveRecord::Migration[6.1]
  def change
    create_table :contributions do |t|
      t.string :contribution_type
      t.string :text
      t.string :title
      t.string :user_email

      t.timestamps
    end
  end
end

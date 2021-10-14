class ChangeTypeToUrl < ActiveRecord::Migration[6.1]
  def change

    
    rename_column :contributions, :contribution_type, :url

  end
end

class RenameCountryToPays < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :country, :pays
  end
end

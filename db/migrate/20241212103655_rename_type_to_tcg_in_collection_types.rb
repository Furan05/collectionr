class RenameTypeToTcgInCollectionTypes < ActiveRecord::Migration[7.1]
  def change
    rename_column :collection_types, :type, :tcg
  end
end

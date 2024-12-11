class AddCategoryToCollections < ActiveRecord::Migration[7.1]
  def change
    add_column :collections, :category, :string
  end
end
